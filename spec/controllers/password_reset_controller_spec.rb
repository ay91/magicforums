require 'rails_helper'

RSpec.describe PasswordResetsController , type: :controller do
  before(:all) do
    @user = User.create(username: "u", email: "u@u.com", password: "123")
  end

  describe "new password reset" do
    it "should render new" do
      get :new
      expect(subject).to render_template(:new)
    end
  end

  describe "create new" do
    it "should check if email exist" do
      params =  {reset: {email: "fakeuser@gmail.com"}}
      post :create, params: params

      expect(@user.password_reset_token).to be_nil
      expect(@user.password_reset_at).to be_nil
      expect(flash[:danger]).to eql("User does not exist")
      expect(subject).to redirect_to(new_password_reset_path)
    end

    it "should update the user password reset token and datetime" do
      params = {reset: {email: "u@u.com"}}
      post :create, params: params

      @user.reload
      expect(@user.password_reset_token).to be_present
      expect(@user.password_reset_at).to be_present
      expect(flash[:success]).to eql("We've sent you instructions on how to reset your password")
      expect(subject).to redirect_to(new_password_reset_path)
    end
  end

  describe "edit password" do
    it "should render edit" do
      params =  {id: "tokenreset"}
      get :edit, params: params

      expect(subject).to render_template(:edit)
      expect(assigns[:token]).to eql("tokenreset")
    end
  end

  describe "update password" do
    it "should render update if token valid" do
      params = {reset: {email: "u@u.com"}}
      post :create, params: params

      @user.reload
      params = {id: @user.password_reset_token, user: {password: "newpassword"}}
      patch :update, params: params

      @user.reload
      user = @user.authenticate("newpassword")
      expect(user).to be_present
      expect(@user.password_reset_at).to be_nil
      expect(subject).to redirect_to(root_path)
      expect(flash[:success]).to eql("Password updated, you may log in now")
    end

    it "should deny password reset if token invalid/expire" do

      params = {id:"faketoken", user: {password: "newpassword"}}
      patch :update, params: params

      @user.reload
      user = @user.authenticate("newpassword")
      expect(user).to eql(false)
      expect(flash[:danger]).to eql("Error, token is invalid or has expired")
      expect(subject).to render_template(:edit)
    end
  end

end

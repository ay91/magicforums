require 'rails_helper'

RSpec.describe SessionsController , type: :controller do

  describe "new session" do
    it "should render new" do
      get :new
      expect(subject).to render_template(:new)
    end
  end

  describe "create session" do
    before(:all) do
      @user = User.create(email: "a@a.com", password: "123", username: "a")
    end
    it "should create session for user" do
      params = {user: {email: "a@a.com", password: "123"}}
      post :create, params: params

      current_user = subject.send(:current_user)
      expect(current_user).to be_present
      expect(current_user.email).to eql("a@a.com")
    end

    it "should deny user if login error" do
        params = {user: {email: "a@a.com", password: "wrongpassword"}}
        post :create, params: params
        current_user = subject.send(:current_user)
        expect(current_user).to be_nil
        expect(flash[:danger]).to eql("Error logging in")
    end
  end
end

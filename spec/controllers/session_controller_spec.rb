require 'rails_helper'

RSpec.describe VotesController , type: :controller do

  describe "new session" do
    it "should render new" do
      get :new
      expect(subject).to render_template(:new)
    end
  end

  describe "create session" do
    before(:all) do
      create(:user)
    end
    it "should create session for user" do
      params = {user: {email: "a@a.com", password: "12345678"}}

    end
  end
end

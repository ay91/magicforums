require 'rails_helper'

RSpec.describe TopicsController , type: :controller do
  before(:all) do
    @admin = User.create(username: "t", email: "t@t.com", password: "123", role: "admin")
    @user = User.create(username: "s", email: "s@s.com", password: "123")
    @topic = Topic.create(title: "testing1234", description: "testing1234")
  end

  describe "topics index" do
    it "should render index" do
      get :index
      expect(subject).to render_template(:index)
    end
  end

  describe "new topic" do
    it "should deny if not logged in" do
      get :new
      expect(flash[:danger]).to eql("You need to login first")
    end

    it "should render new only for admin" do
      get :new, session: {id: @admin.id}
      expect(subject).to render_template(:new)
    end

    it "should deny user access to topic" do
      get :new, session: {id: @user.id}
      expect(flash[:danger]).to eql("You're not authorized")
    end
  end

  describe "create topic" do
    it "should create topic for admin" do
      params = {topic: {title: "New title 12345", description: "New title 12345"}}
      post :create, params: params, session: {id: @admin.id}

      topic = Topic.find_by(title: "New title 12345")

      expect(Topic.count).to eql(2)
      expect(topic.title).to eql("New title 12345")
      expect(topic.description).to eql("New title 12345")
      expect(flash[:success]).to eql("You've created a new topic.")
    end

    it "should deny user" do
      params = {topic: {title: "New title 12345", description: "New title 12345"}}
      post :create, params: params, session: {id: @user.id}
      expect(flash[:danger]).to eql("You're not authorized")
    end

    it "should deny if user not logged in" do
      post :create
      expect(flash[:danger]).to eql("You need to login first")
    end
  end

  describe "edit topic" do
    it "should deny if user not logged in" do
      get :edit
      expect(flash[:danger]).to eql("You need to login first")
    end

    it "should deny user" do
      get :edit, session: {id: @user.id}
    end

    it "should render edit for admin" do

    end
  end



end

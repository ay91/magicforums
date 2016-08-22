require 'rails_helper'

RSpec.describe PostsController , type: :controller do
  before(:all) do
    @admin = User.create(username: "t", email: "t@t.com", password: "123", role: "admin")
    @user = User.create(username: "s", email: "s@s.com", password: "123")
    @post = Post.create(title: "testing1234", body: "testing1234")
  end

  describe 'posts index' do
    it 'should render posts index' do
      params =  {topic_id: @topic.id}
      get :index, params: params
      expect(subject).to render_template(:index)
    end
  end

  describe 'create post' do
    it 'should '
  end

require 'rails_helper'

RSpec.describe PostsController , type: :controller do
  before(:all) do
    # @topic = Topic.create(title: "testing123456", description: "testing1234567")
    # @admin = User.create(username: "t", email: "t@t.com", password: "123", role: "admin")
    # @user = User.create(username: "s", email: "s@s.com", password: "123")
    # @post = Post.create(title: "testing1234", body: "testing1234", topic_id: @topic.id, user_id: @user.id)
    # @unauthorized_user = User.create(username: "q", email: "q@q.com", password: "123")
    @topic = create(:topic)
    @user = create(:user)
    @admin = create(:user, :admin, :sequenced_email, :sequenced_username)
    @unauthorized_user = create(:user, :sequenced_email, :sequenced_username)
    4.times{create(:post, :sequenced_title, :sequenced_body, topic_id: @topic.id, user_id: @user.id)}
  end

  describe 'posts index' do
    it 'should render posts index' do
      params =  {topic_id: @topic.id}
      get :index, params: params
      expect(subject).to render_template(:index)
    end
  end

  describe 'create post' do
    it "should deny user if not logged in" do
      params = {topic_id: @topic.id, post: {title: "testposttest", body: "testpost test"}}
      post :create, params: params
      expect(flash[:danger]).to eql("You need to login first")
    end

    it "should create new post" do
      params = {topic_id: @topic.id, post: {title: "testing 21334", body: "testing 21334"}}
      post :create, xhr: true, params: params, session: {id: @user.id}
      post = Post.find_by(title: "testing 21334")

      expect(post.title).to eql("testing 21334")
      expect(post.body).to eql("testing 21334")
      expect(flash[:success]).to eql("You've created a new post")
      expect(Post.count).to eql(5)
    end
  end
    describe 'edit post' do
      it 'should deny user if not logged in' do
        @post = Post.first
        params = {topic_id: @topic.id, id: @post.id}
        get :edit, params: params, xhr: true
        expect(flash[:danger]).to eql("You need to login first")

      end

      it "should deny unauthorized user" do
        @post = Post.first
        params = {topic_id: @topic.id, id: @post.id}
        get :edit, params: params, session: {id: @unauthorized_user.id}, xhr: true
        expect(flash[:danger]).to eql("You're not authorized")

      end

      it "should render edit for user" do
        @post = Post.first
        params = {topic_id: @topic.id, id: @post.id}
        get :edit, params: params, session: {id: @user.id}, xhr: true

        expect(subject).to render_template(:edit)
      end
    end

    describe "update post" do
      it "should deny user if not logged in" do
        @post = Post.first
        params = {topic_id: @topic.id, id: @post.id, post: {title: "update post", body: "update post 123"}}
        patch :update, params: params, xhr: true
        expect(flash[:danger]).to eql("You need to login first")
      end

      it "should deny unauthorized user" do
        @post = Post.first
        params = {topic_id: @topic.id, id: @post.id, post: {title: "update post", body: "update post 123"}}
        patch :update, params: params, xhr: true, session: {id: @unauthorized_user.id}

        expect(flash[:danger]).to eql("You're not authorized")
      end

      it "should render update for user" do
        @post = Post.first
        params = {topic_id: @topic.id, id: @post.id, post: {title: "update post", body: "update post 123"}}
        patch :update, params: params, xhr: true, session: {id: @user.id}

        @post.reload
        expect(@post.title).to eql("update post")
        expect(@post.body).to eql("update post 123")
        expect(flash[:success]).to eql("Post Updated")
      end
    end

  describe "delete post" do
      it "should deny user if not logged in" do
        @post = Post.first
        delete :destroy, params: {topic_id: @topic.id, id: @post.id}, xhr: true

        expect(flash[:danger]).to eql("You need to login first")
      end

    it "should deny unauthorized user" do
      @post = Post.first
      delete :destroy, params: {topic_id: @topic.id, id: @post.id}, xhr: true, session: {id: @unauthorized_user.id}

      expect(flash[:danger]).to eql("You're not authorized")
    end

    it "should render delete for user" do
      @post = Post.first
      delete :destroy, params: {topic_id: @topic.id, id: @post.id}, xhr: true, session: {id: @user.id}
      @post = Post.find_by(id: @post.id)

      expect(Post.count).to eql(3)
      expect(@post).to be_nil
    end

    it "should delete if admin" do
      @post = Post.first
      delete :destroy, params: {topic_id: @topic.id, id: @post.id}, xhr: true, session: {id: @admin.id}
      @post = Post.find_by(id: @post.id)

      expect(Post.count).to eql(3)
      expect(@post).to be_nil
    end
  end

end

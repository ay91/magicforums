require 'rails_helper'

RSpec.describe CommentsController , type: :controller do
  before(:all) do
    # @topic = Topic.create(title: "testing123456", description: "testing1234567")
    # @admin = User.create(username: "t", email: "t@t.com", password: "123", role: "admin")
    # @user = User.create(username: "s", email: "s@s.com", password: "123")
    # @post = Post.create(title: "testing1234", body: "testing1234", topic_id: @topic.id, user_id: @user.id)
    # @unauthorized_user = User.create(username: "q", email: "q@q.com", password: "123")
    # @comment = Comment.create(body: "testing12345", post_id: @post.id, user_id: @user.id)
    @topic = create(:topic)
    @admin = create(:user, :admin, :sequenced_email, :sequenced_username)
    @user = create(:user)
    @post = create(:post, :sequenced_title, :sequenced_body, topic_id: @topic.id, user_id: @user.id)
    @unauthorized_user = create(:user, :sequenced_email, :sequenced_username)
    4.times{create(:comment, :sequenced_body, post_id: @post.id, user_id: @user.id)}
  end

  describe 'comments index' do
    it 'should render comments index' do
      params =  {topic_id: @topic.id, post_id: @post.id}
      get :index, params: params
      expect(subject).to render_template(:index)
    end
  end

  describe 'create comment' do
    it "should deny user if not logged in" do
      params = {topic_id: @topic.id, post_id: @post.id, comment: {body: "testpost test"}}
      post :create, params: params
      expect(flash[:danger]).to eql("You need to login first")
    end

    it "should create new comment" do
      params = {topic_id: @topic.id, post_id: @post.id, comment: {body: "testpost test"}}
      post :create, xhr: true, params: params, session: {id: @user.id}
      comment = Comment.find_by(body: "testpost test")

      expect(comment.body).to eql("testpost test")
      expect(flash[:success]).to eql("You've created a new comment")
      expect(Comment.count).to eql(5)
    end
  end

  describe 'edit comment' do
    it 'should deny user if not logged in' do
      @comment = Comment.first
      params = {topic_id: @topic.id, post_id: @post.id, id: @comment.id}
      get :edit, params: params, xhr: true
      expect(flash[:danger]).to eql("You need to login first")

    end

    it "should deny unauthorized user" do
      @comment = Comment.first
      params = {topic_id: @topic.id, post_id: @post.id, id: @comment.id}
      get :edit, params: params, session: {id: @unauthorized_user.id}, xhr: true
      expect(flash[:danger]).to eql("You're not authorized")

    end

    it "should render edit for user" do
      @comment = Comment.first
      params = {topic_id: @topic.id, post_id: @post.id, id: @comment.id}
      get :edit, params: params, session: {id: @user.id}, xhr: true

      expect(subject).to render_template(:edit)
    end
  end

  describe "update comment" do
    @comment = Comment.first
    it "should deny user if not logged in" do
      params = {topic_id: @topic.id, post_id: @post.id, id: @comment.id, comment: { body: "testing12345"}}
      patch :update, params: params, xhr: true
      expect(flash[:danger]).to eql("You need to login first")
    end

    it "should deny unauthorized user" do
      @comment = Comment.first
      params = {topic_id: @topic.id, post_id: @post.id, id: @comment.id, comment: { body: "testing12345"}}
      patch :update, params: params, xhr: true, session: {id: @unauthorized_user.id}

      expect(flash[:danger]).to eql("You're not authorized")
    end

    it "should render update for user" do
      @comment = Comment.first
      params = {topic_id: @topic.id, post_id: @post.id, id: @comment.id, comment: { body: "testing12345"}}
      patch :update, params: params, xhr: true, session: {id: @user.id}

      @comment.reload
      expect(@comment.body).to eql("testing12345")
      expect(flash[:success]).to eql("You've updated your comment")
    end
  end

  describe "delete comment" do
      it "should deny user if not logged in" do
        @comment = Comment.first
        delete :destroy, params: {topic_id: @topic.id, post_id: @post.id, id: @comment.id}, xhr: true

        expect(flash[:danger]).to eql("You need to login first")
      end

    it "should deny unauthorized user" do
      @comment = Comment.first
      delete :destroy, params: {topic_id: @topic.id, post_id: @post.id, id: @comment.id}, xhr: true, session: {id: @unauthorized_user.id}

      expect(flash[:danger]).to eql("You're not authorized")
    end

    it "should render delete for user" do
      @comment = Comment.first
      delete :destroy, params: {topic_id: @topic.id, post_id: @post.id, id: @comment.id}, xhr: true, session: {id: @user.id}
      @comment = Comment.find_by(id: @comment.id)

      expect(Comment.count).to eql(3)
      expect(@comment).to be_nil
    end

    it "should delete if admin" do
      @comment = Comment.first
      delete :destroy, params: {topic_id: @topic.id, post_id: @post.id, id: @comment.id}, xhr: true, session: {id: @admin.id}
      @comment = Comment.find_by(id: @comment.id)

      expect(Comment.count).to eql(3)
      expect(@comment).to be_nil
    end
  end

end

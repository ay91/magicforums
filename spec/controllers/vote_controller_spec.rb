require 'rails_helper'

RSpec.describe VotesController , type: :controller do
  before(:all) do
    @user = User.create(username: "s", email: "s@s.com", password: "123")
    @admin = User.create(username: "t", email: "t@t.com", password: "123", role: "admin")
    @topic = Topic.create(title: "testing123456", description: "testing1234567", user_id: @admin.id)
    @post = Post.create(title: "testing12345", body: "testing1234556", topic_id: @topic.id, user_id: @user.id)
    @comment = Comment.create(body: "testing12345", post_id: @post.id, user_id: @user.id)


  end

  describe "create upvote" do
    it "should deny user if not logged in" do
      params = {comment_id: @comment.id}
      post :upvote, params: params, xhr: true
      expect(flash[:danger]).to eql("You need to login first")
    end

    it "should create vote if vote not exist" do
      params = {comment_id: @comment.id}
      post :upvote, params: params, xhr: true, session: {id: @user.id}

      expect(Vote.count).to eql(1)

    end

    it "should find vote if vote exist" do
      @vote_up = Vote.create(comment_id: @comment.id, user_id: @user.id, value: 1)
      expect(Vote.count).to eql(1)
      params = {comment_id: @comment.id}
      post :upvote, params: params, xhr: true, session: {id: @user.id}

      expect(Vote.count).to eql(1)
    end

    it "should +1 to upvote" do
      @vote_up = Vote.create(comment_id: @comment.id, user_id: @user.id, value: 1)
      params = {comment_id: @comment.id}
      post :upvote, params: params, xhr: true, session: {id: @user.id}

      expect(@vote_up.value).to eql(1)
      expect(flash[:success]).to eql("Upvoted!")
    end
  end

  describe "create downvote" do
    it "should deny user if not logged in" do
      params = {comment_id: @comment.id}
      post :downvote, params: params, xhr: true
      expect(flash[:danger]).to eql("You need to login first")
    end

    it "should create vote if vote not exist" do
      params = {comment_id: @comment.id}
      post :downvote, params: params, xhr: true, session: {id: @user.id}

      expect(Vote.count).to eql(1)

    end

    it "should find vote if vote exist" do
      @vote_down = Vote.create(comment_id: @comment.id, user_id: @user.id, value: -1)
      expect(Vote.count).to eql(1)
      params = {comment_id: @comment.id}
      post :downvote, params: params, xhr: true, session: {id: @user.id}

      expect(Vote.count).to eql(1)
    end

    it "should -1 to downvote" do
      @vote_down = Vote.create(comment_id: @comment.id, user_id: @user.id, value: -1)
      params = {comment_id: @comment.id}
      post :downvote, params: params, xhr: true, session: {id: @user.id}

      expect(@vote_down.value).to eql(-1)
      expect(flash[:danger]).to eql("Downvoted!")
    end
  end

end

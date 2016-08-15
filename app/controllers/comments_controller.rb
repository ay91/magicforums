class CommentsController < ApplicationController
  respond_to :js
  before_action :authenticate!, only: [:create, :edit, :update, :new, :destroy]

  def index
    @topic = Topic.includes(:posts).find_by(id: params[:topic_id])
    @post = Post.includes(:comments).find_by(id: params[:post_id])
    @comments = @post.comments.order(created_at: :desc).page params[:page]
    @comment = Comment.new

  end

  def create
    @post = Post.find_by(id: params[:post_id])
    @topic = @post.topic
    @comment = current_user.comments.build(comment_params.merge(post_id: params[:post_id]))
    @new_comment = Comment.new

    if @comment.save
      CommentBroadcastJob.set(wait: 0.1.seconds).perform_later("create", @comment)
      flash.now[:success] = "You've created a new comment"
    else
      flash.now[:danger] = @comment.errors.full_messages
    end
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
    @post = @comment.post
    @topic = @post.topic
    authorize @comment
  end

  def update
    @comment = Comment.find_by(id: params[:id])
    @post = @comment.post
    @topic = @post.topic

    if @comment.update(comment_params)
      flash.now[:success] = "You've updated your comment"
    else
      flash.now[:danger] = @comment.errors.full_messages
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @post = @comment.post
    @topic = @post.topic

    if @comment.destroy
      flash.now[:success] = "Comment Deleted!"
    end
    authorize @comment

  end

  private

    def comment_params
      params.require(:comment).permit(:body, :image)
    end
end

class CommentsController < ApplicationController
  respond_to :js
  before_action :authenticate!, only: [:create, :edit, :update, :new, :destroy]

  def index
    @topic = Topic.includes(:posts).find_by(id: params[:topic_id])
    @post = Post.includes(:comments).find_by(id: params[:post_id])
    @comments = @post.comments
    @comment = Comment.new

  end

  def create
    @post = Post.find_by(id: params[:post_id])
    @topic = @post.topic
    @comment = current_user.comments.build(comment_params.merge(post_id: params[:post_id]))
    @new_comment = Comment.new

    if @comment.save
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
    @topic = Topic.find_by(id: params[:topic_id])
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.find_by(id: params[:id])

    if @comment.update(comment_params)
      redirect_to topic_post_comments_path(@topic, @post)
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @post = @comment.post
    @topic = @post.topic
    authorize @comment

    if @comment.destroy
      redirect_to topic_post_comments_path
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :image)
    end
end

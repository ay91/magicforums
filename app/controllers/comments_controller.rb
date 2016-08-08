class CommentsController < ApplicationController

  def index
    @topic = Topic.includes(:posts).find_by(id: params[:topic_id])
    @post = Post.includes(:comments).find_by(id: params[:post_id])
    @comments = @post.comments

  end

  def new
    @post = Post.find_by(id: params[:post_id])
    @topic = @post.topic
    @comment = Comment.new
  end

  def create
    @post = Post.find_by(id: params[:post_id])
    @topic = @post.topic
    @comment = Comment.new(comment_params.merge(post_id: params[:post_id]))
    if @comment.save
      redirect_to topic_post_comments_path
    else
      redirect_to new_topic_post_comment_path
    end
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
    @post = @comment.post
    @topic = @post.topic
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

    if @comment.destroy
      redirect_to topic_post_comments_path
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :image)
    end
end

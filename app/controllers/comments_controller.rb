class CommentsController < ApplicationController

  def index
    @topic = Topic.includes(:posts).find_by(id: params[:topic_id])
    @post = Post.find_by(id: params[:post_id])
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
      @comment = Comment.new(post_params.merge(post_id: params[:post_id]))
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
        @post = Post.find_by(id: params[:id])
        @comment = Comment.find_by(id: params[:id])

          if @comment.update(post_params)
            redirect_to topic_post_comments_path(@topic, @post)
          else
            render :edit
          end
      end

      def destroy
        @post = Post.find_by(id: params[:post_id])
        @topic = @post.topic
        @comment = @post.comment

          if @comment.destroy
            redirect_to topic_post_comment_path
          end
      end

      def post_params
        params.require(:comment).permit(:body)
      end
end

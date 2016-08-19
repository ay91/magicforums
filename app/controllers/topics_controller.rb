class TopicsController < ApplicationController
  respond_to :js
  before_action :authenticate!, only: [:create, :edit, :update, :new, :destroy]

  def index
    @topics = Topic.all.page params[:page]

  end

  def new
    @topic = Topic.new
    authorize @topic
  end

  def create
    @topic = current_user.topics.build(topic_params)

      if @topic.save
        flash[:success] = "You've created a new topic."
        redirect_to topics_path
      else
        flash[:danger] = @topic.errors.full_messages
        redirect_to new_topic_path
      end
  end

  def edit
    @topic = Topic.friendly.find(params[:id])
    authorize @topic
  end

  def update
    @topic = Topic.friendly.find(params[:id])

      if @topic.update(topic_params)
        flash.now[:success] = "Topic Updated!"
      end
  end

  def destroy
    @topic = Topic.friendly.find(params[:id])
    authorize @topic

      if @topic.destroy
        flash.now[:danger] = "Topic Deleted!"

      end
  end


  private

  def topic_params
    params.require(:topic).permit(:title, :description)
  end

end

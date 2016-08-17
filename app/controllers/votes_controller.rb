class VotesController < ApplicationController
  respond_to :js
  before_action :authenticate!

  def upvote
    @vote = current_user.votes.find_or_create_by(comment_id: params[:comment_id])

    if @vote.update(value: 1)
      VoteBroadcastJob.perform_later(@vote.comment)
      flash.now[:success] = "Upvoted!"
      
    end
  end

  def downvote
    @vote = current_user.votes.find_or_create_by(comment_id: params[:comment_id])

    if @vote.update(value: -1)
      VoteBroadcastJob.perform_later(@vote.comment)
      flash.now[:success] = "Downvoted!"

    end
  end
end

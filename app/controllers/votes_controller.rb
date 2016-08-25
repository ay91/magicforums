class VotesController < ApplicationController
  respond_to :js
  before_action :authenticate!
  before_action :find_or_create_vote

  def upvote
  
    vote_value(1)
    flash.now[:success] = "Upvoted!"
  end

  def downvote
    vote_value(-1)
    flash.now[:danger] = "Downvoted!"
  end

  private

  def find_or_create_vote
    @vote = current_user.votes.find_or_create_by(comment_id: params[:comment_id])
  end

  def vote_value(value)
    @vote.update(value: value)
    VoteBroadcastJob.perform_later(@vote.comment)
  end

end

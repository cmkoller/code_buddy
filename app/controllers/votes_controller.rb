class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    review = Review.find(params[:review_id])
    vote = review.votes.find_or_initialize_by(user: current_user)
    vote.assign_attributes(vote_params)
    vote.save
    redirect_to buddy_path(review.buddy)
  end

  private

  def vote_params
    params.require(:vote).permit(:vote_value)
  end

end

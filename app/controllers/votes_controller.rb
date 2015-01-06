class VotesController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    @vote = @review.votes.build(vote_params)
    @vote.user_id = current_user.id
    @vote.review_id = @review.id
    unless @vote.save
    end
    redirect_to buddy_path(@review.buddy)
  end


  private

    def vote_params
      params.require(:vote).permit(:vote_value)
    end


end

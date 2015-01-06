class VotesController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    @vote = @review.votes.build(vote_params)
    @vote.user_id = current_user.id
    @vote.review_id = @review.id
      if @vote.save
        redirect_to root_path
      else
        redirect_to root_path
      end
  end


  private

    def vote_params
      params.require(:vote).permit(:vote_value)
    end


end

class  ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @buddy = Buddy.find(params[:buddy_id])
    @review = Review.new(review_params)
    @review.buddy_id = @buddy.id
    @review.user_id = current_user.id
    if @review.save
      flash[:notice] = "You've successfully submitted a review!"
      @buddy.reviewed(@review)
      redirect_to buddy_path(@buddy)
    else
      flash[:alert] = @review.errors.full_messages.join(".  ")
      redirect_to buddy_path(@buddy)
    end
  end

  def edit
    @review = current_user.reviews.find(params[:id])
  end

  def update
    @review = current_user.reviews.find(params[:id])
    @buddy = @review.buddy
    if @review.update(review_params)
      flash[:notice] = "You've successfully updated your review!"
      redirect_to @buddy
    else
      flash[:alert] = @review.errors.full_messages.join(".  ")
      redirect_to @buddy
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @buddy = @review.buddy
    if current_user.admin? || current_user.id == @review.user_id
      @review.destroy
      flash[:notice] = "You've successfully deleted a review!"
    else
      flash[:alert] = "You are not authorized to do this."
    end
    redirect_to buddy_path(@buddy)
  end


  private
  def review_params
    params.require(:review).permit(:comment, :rating)
  end

end

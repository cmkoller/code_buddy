class  ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    @buddy = Buddy.find(params[:buddy_id])
    @review = Review.new(review_params)
    @review.buddy_id = @buddy.id
    @review.user_id = current_user.id
    if @review.save
      flash[:notice] = "You've successfully submitted a review!"
      redirect_to buddy_path(@buddy)
    else
      flash[:alert] = @review.errors.full_messages
      redirect_to buddy_path(@buddy)
    end
  end

  def edit
    @review = current_user.reviews.find(params[:id])
    @buddy = Buddy.find(params[:buddy_id])
  end

  def update
    @review = current_user.reviews.find(params[:id])
    @buddy = Buddy.find(params[:buddy_id])
    if current_user.id == @review.user_id
      if @review.update(review_params)
        flash[:notice] = "You've successfully updated your review!"
        redirect_to @buddy
      else
        flash[:alert] = @review.errors.full_messages
        redirect_to @buddy
      end
    else
      flash[:alert] = "You are not the owner of that review"
      redirect_to @buddy
    end
  end

  def destroy
    @buddy = Buddy.find(params[:buddy_id])
    @review = current_user.reviews.find(params[:id])
    @review.destroy
    flash[:notice] = "You've successfully deleted a review!"
    redirect_to @buddy
  end


  private
  def review_params
    params.require(:review).permit(:comment, :rating, :user)
  end

end

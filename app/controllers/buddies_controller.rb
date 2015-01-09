class  BuddiesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:query]
      @buddies = Buddy.search(params[:query])
    else
      @buddies = Buddy.all
    end
    @buddies = @buddies.page(params[:page]).per(10)
  end

  def new
    @buddy = current_user.buddies.build
  end

  def create
    @buddy = current_user.buddies.build(buddy_params)

    if @buddy.save
      flash[:success] = "You've successfully submitted a buddy!"
      redirect_to @buddy
    else
      flash[:alert] = @buddy.errors.full_messages.join(".  ")
      render "new"
    end
  end

  def show
    @buddy = Buddy.find(params[:id])
    @reviews = @buddy.reviews.order(created_at: :desc).page(params[:page]).per(10)
  end

  def update
    @buddy = current_user.buddies.find(params[:id])
    if current_user.id == @buddy.user_id
      if @buddy.update(buddy_params)
        flash[:success] = "You've successfully updated a buddy!"
        redirect_to @buddy
      else
        flash[:alert] = @buddy.errors.full_messages.join(".  ")
        render "edit"
      end
    else
      redirect_to root_path
      flash[:alert] = "You are not the owner of that buddy"
    end
  end

  def edit
    @buddy = current_user.buddies.find(params[:id])
  end

  def destroy
    @buddy = Buddy.find(params[:id])
    if current_user.admin? || current_user.id == @buddy.user_id
      @buddy.destroy
      flash[:success] = "You've successfully deleted a buddy!"
      redirect_to root_path
    else
      flash[:alert] = "You are not authorized to do this."
      redirect_to buddy_path(@buddy)
    end
  end

  private

  def buddy_params
    params.require(:buddy).permit(:title, :description, :url)
  end

  def find_buddy
    @buddy ||= Buddy.find(params[:id])
  end

end

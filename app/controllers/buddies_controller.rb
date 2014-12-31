class  BuddiesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @buddies = Buddy.all
  end

  def new
    @buddy = current_user.buddies.build
  end

  def create
    @buddy = current_user.buddies.build(buddy_params)

    if @buddy.save
      flash[:notice] = "You've successfully submitted a buddy!"
      redirect_to @buddy
    else
      flash[:alert] = "Fail"
      render "new"
    end
  end

  def show
    @buddy = Buddy.find(params[:id])
  end

  def update
    @buddy = Buddy.find(params[:id])
    if current_user.id == @buddy.user_id
      if @buddy.update(buddy_params)
        flash[:notice] = "You've successfully updated a buddy!"
        redirect_to @buddy
      else
        render "edit"
      end
    else
      redirect_to root_path
      flash[:alert] = "You are not the owner of that buddy"
    end
  end

  def edit
    @buddy = Buddy.find(params[:id])
  end

  def destroy
    @buddy = Buddy.find(params[:id])
    @buddy.destroy
    flash[:notice] = "You've successfully deleted a buddy!"
    redirect_to root_path
  end

  private

  def buddy_params
    params.require(:buddy).permit(:title, :description, :url)
  end

  def find_buddy
    @buddy ||= Buddy.find(params[:id])
  end
end

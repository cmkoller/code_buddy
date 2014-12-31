class  ResourcesController < ApplicationController
  before_action :find_resource, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @resources = Resource.all
  end

  def new
    @resource = current_user.resources.build
  end

  def create
    @resource = current_user.resources.build(resource_params)

    if @resource.save
      flash[:notice] = "You've successfully submitted a resource!"
      redirect_to @resource
    else
      flash[:alert] = "Fail"
      render "new"
    end
  end

  # def show
  # end

  def update
    if current_user.id == @resource.user_id
      if @resource.update(resource_params)
        flash[:notice] = "You've successfully updated a resource!"
        redirect_to @resource
      else
        render "edit"
      end
    else
      redirect_to root_path
      flash[:alert] = "You are not the owner of that resource"
    end
  end

  # def edit
  # end

  def destroy
    @resource.destroy
    flash[:notice] = "You've successfully deleted a resource!"
    redirect_to root_path
  end

  private

  def resource_params
    params.require(:resource).permit(:title, :description, :url)
  end

  def find_resource
    @resource ||= Resource.find(params[:id])
  end

end

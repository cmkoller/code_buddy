class  ResourcesController < ApplicationController
  before_action :find_resource, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @resources = Resource.all
  end

  def new
    @resource = Resource.new
  end

  def create
    @resource = Resource.new(resource_params)

    if @resource.save
      flash[:notice] = "You've successfully submitted a resource!"
      redirect_to @resource
    else
      flash[:alert] = "Fail"
      render "new"
    end
  end

  def show
  end

  def update
    if @resource.update(resource_params)
      flash[:notice] = "You've successfully updated a resource!"
      redirect_to @resource
    else
      render "edit"
    end
  end

  def edit
  end

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
    @resource = Resource.find(params[:id])
  end

end

class  ResourcesController < ApplicationController
  # before_action :find_resource, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!, except: [:index, :show]

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
      redirect_to resources_path
    else
      flash[:notice] = "Fail"
      render 'new'
    end
  end

  private

  def resource_params
    params.require(:resource).permit(:title, :description, :url)
  end

  def find_resource
    @resource = Resource.find(params[:id])
  end

end

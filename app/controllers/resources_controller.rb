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
    @resource = Resource.new
    flash[:notice] = "You've successfully submitted a resource!"
    redirect_to @resource
  end


end

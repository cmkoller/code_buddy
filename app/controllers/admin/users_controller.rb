module Admin
  class UsersController < ApplicationController
    before_action :authorize!
    before_action :authenticate_user!

    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:notice] = "User successfully deleted!"
      redirect_to admin_users_path
    end
  end
end

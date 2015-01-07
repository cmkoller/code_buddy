class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def authorize!
    if current_user.nil? || !current_user.admin?
      flash[:notice] = "You are not authorized to do this."
      redirect_to root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name << :last_name << :display_name
    devise_parameter_sanitizer.for(:account_update) << :first_name << :last_name << :display_name << :avatar
  end

end

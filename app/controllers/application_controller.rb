class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :authenticate_user!

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user.admin? || current_user?(@user)
  end
  
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :name, :password)}
  end
end

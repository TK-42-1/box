class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
    @current = current_user
    if @current.admin? 
      render 'index'
    else
      flash[:error] = "Unauthorized access"
      redirect_to @current
    end
  end
  
  def new
    @user = User.new
    @current = current_user
    if @current.admin? 
      render 'new'
    else
      flash[:error] = "Unauthorized access"
      redirect_to @current
    end
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "User successfully created"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
    @current = current_user
    if @current.admin? 
      render 'edit'
    else
      flash[:error] = "Unauthorized access"
      redirect_to @current
    end
  end
  
  def update
    params[:user].delete(:password) if params[:user][:password].blank?
    if @user.update_attributes(user_params)
      flash[:success] = "User updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :name, :email, :password, :password_confirmation, :admin)
  end
  
  def signed_in_user
    store_location
    redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user.admin? || current_user?(@user)
  end
  
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
  def current_user
    remember_token = User.hash(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end
end

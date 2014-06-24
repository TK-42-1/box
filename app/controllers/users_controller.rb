class UsersController < ApplicationController
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
    @current = current_user
    # if current_user?(@user)  
    #   render 'show'
    # else
    #   flash[:error] = "Unauthorized access"
    #   redirect_to @current
    # end
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
end

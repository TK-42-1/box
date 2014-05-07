class BoxesController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @boxes = Box.paginate(page: params[:page])
    @current = current_user
  end
  
  def new
    @box = Box.new
  end
  
  def create
    @box = Box.new(box_params)
    
    if @box.save
      flash[:success] = "Box successfully created"
      redirect_to @box
    else
      render 'new'
    end
  end
  
  def show
    @box = Box.find(params[:id])
  end

  def edit
    @box = Box.find(params[:id])
    @current = current_user
    if @current.admin? 
      render 'edit'
    else
      flash[:error] = "Unauthorized access"
      redirect_to 'boxes/index'
    end
  end
  
  def update
    @box = Box.find(params[:id])
    if @box.update_attributes(box_params)
      flash[:success] = "Box updated"
      redirect_to @box
    else
      render 'edit'
    end
  end
  
  def destroy
    Box.find(params[:id]).destroy
    flash[:success] = "Box deleted"
    redirect_to boxes_path
  end
  
  def print
    @box = Box.find(params[:id])
    @print = true
  end
  
  def update_departments
    @company = Company.find(params[:company_id])
    @departments = @company.departments
    render :layout => !request.xhr?
  end
  
  private
  
  def box_params
    params.require(:box).permit(:description, :month, :year, :destroy_by, :user_id, :company_id, :department_id)
  end
end

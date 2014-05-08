class CompaniesController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :admin_user, only: [:destroy, :children]

  def index
    @departments = Department.paginate(page: params[:page])
    @current = current_user
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)
  
    if @department.save
      flash[:success] = "Department successfully created"
      redirect_to @department
    else
      render 'new'
    end
  end

  def show
    @department = Department.find(params[:id])
    @departments = @department.departments
  end

  def edit
    @department = Department.find(params[:id])
    @current = current_user
    if @current.admin? 
      render 'edit'
    else
      flash[:error] = "Unauthorized access"
      redirect_to 'departments/index'
    end
  end

  def update
    @department = Department.find(params[:id])
    if @department.update_attributes(department_params)
      flash[:success] = "Department updated"
      redirect_to @department
    else
      render 'edit'
    end
  end
  
  def destroy
    Department.find(params[:id]).destroy
    flash[:success] = "Department deleted"
    redirect_to departments_path
  end
  
  private

  def department_params
    params.require(:department).permit!
    # (:name, divisions_attributes: [:id, :department_id, :department_id])
  end
end

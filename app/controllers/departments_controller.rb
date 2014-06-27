class DepartmentsController < ApplicationController
  before_action :admin_user, only: [:destroy, :children]
  helper_method :sort_column, :sort_direction

  def index
    @departments = Department.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 30)
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
    @companies = @department.companies
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

  def sort_column
    Department.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def department_params
    params.require(:department).permit!
    # (:name, divisions_attributes: [:id, :department_id, :department_id])
  end
end

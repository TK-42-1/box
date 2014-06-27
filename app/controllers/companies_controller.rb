class CompaniesController < ApplicationController
  before_action :admin_user, only: [:destroy, :children]
  helper_method :sort_column, :sort_direction

  def index
    @companies = Company.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 30)
    @current = current_user
  end

  def new
    @company = Company.new
    
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      flash[:success] = "Company successfully created"
      redirect_to @company
    else
      render 'new'
    end
  end

  def show
    @company = Company.find(params[:id])
  end

  def edit
    @company = Company.find(params[:id])
    @current = current_user
    if @current.admin? 
      render 'edit'
    else
      flash[:error] = "Unauthorized access"
      redirect_to 'companies/index'
    end
  end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(company_params)
      flash[:success] = "Company updated"
      redirect_to @company
    else
      render 'edit'
    end
  end
  
  def destroy
    Company.find(params[:id]).destroy
    flash[:success] = "Company deleted"
    redirect_to companies_path
  end
  
  private

  def sort_column
    Company.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def company_params
    params.require(:company).permit(:name, {:department_ids => []}, divisions_attributes: [:id, :company_id, {:department_ids => []}])
  end
end

class CompaniesController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :admin_user, only: [:destroy, :children]

  def index
    @companies = Company.paginate(page: params[:page])
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
    @departments = @company.departments
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

  def company_params
    params.require(:company).permit!
    # (:name, divisions_attributes: [:id, :company_id, :department_id])
  end
end

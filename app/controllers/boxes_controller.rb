class BoxesController < ApplicationController
  before_action :admin_user, only: :destroy
  helper_method :sort_column, :sort_direction
  
  def index
    @boxes = Box.filter(params[:filter]).deptfilter(params[:deptfilter]).search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 30)
    @current = current_user
  end
  
  def new
    @box = Box.new
    @company = Company.all
    @next = Box.last.id.to_i + 1
  end
  
  def create
    @box = Box.new(box_params)
    if @box.save
      flash[:success] = "Box successfully created"
      redirect_to new_box_path
    else
      render 'new'
    end
  end
  
  def show
    @box = Box.find(params[:id])
    # MGT 
    #@location = Location.find_by code: @box.location_code
    @location = @box.location_code
  end

  def edit
    @box = Box.find(params[:id])
    @current = current_user
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
    @boxes = Box.find(params[:print])
    @print = true
    render :print
  end

  def checkout

    @boxes = @boxes = Box.filter(params[:filter]).search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 25) || Box.find(params[:print])
    @user = current_user
  end
  
  def update_departments
    @company = Company.find(params[:company_id])
    @departments = @company.departments
    render :layout => !request.xhr?
  end
  
  private
  
  def box_params
    params.require(:box).permit(:description, :month, :year, :destroy_by, :user_id, :company_id, :department_id, :location_code, :stored_by, :destroyed_at )
  end

  def sort_column
    Box.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end

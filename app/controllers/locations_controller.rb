class LocationsController < ApplicationController
  before_action :admin_user, only: [:destroy, :children]
  helper_method :sort_column, :sort_direction

  def index
    @locations = Location.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 30)
    @current = current_user
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
  
    if @location.save
      flash[:success] = "Location successfully created"
      redirect_to 'new'
    else
      render 'new'
    end
  end

  def show
    @location = Location.find(params[:id])
    @boxes = @location.boxes
  end

  def edit
    @location = Location.find(params[:id])
    @current = current_user
    if @current.admin? 
      render 'edit'
    else
      flash[:error] = "Unauthorized access"
      redirect_to 'locations/index'
    end
  end

  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(location_params)
      flash[:success] = "Location updated"
      redirect_to @location
    else
      render 'edit'
    end
  end

  def print
    @location = Location.find(params[:id])
  end
  
  def destroy
    location.find(params[:id]).destroy
    flash[:success] = "location deleted"
    redirect_to locations_path
  end
  
  private

  def sort_column
    Location.column_names.include?(params[:sort]) ? params[:sort] : "code"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def location_params
    params.require(:location).permit!
    # (:name, divisions_attributes: [:id, :department_id, :department_id])
  end
end

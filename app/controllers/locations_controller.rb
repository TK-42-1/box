class LocationsController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :admin_user, only: [:destroy, :children]

  def index
    @locations = Location.paginate(page: params[:page])
    @current = current_user
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
  
    if @location.save
      flash[:success] = "location successfully created"
      redirect_to @location
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
      flash[:success] = "location updated"
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

  def location_params
    params.require(:location).permit!
    # (:name, divisions_attributes: [:id, :department_id, :department_id])
  end
end

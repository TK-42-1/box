class BoxesController < ApplicationController
  
  def index
    @boxes = Box.paginate(page: params[:page])
  end
  
  def new
    @box = Box.new
  end
  
  def create
    @box = Box.new(boxes_params)
    
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
  end
  
  def update
  end
end

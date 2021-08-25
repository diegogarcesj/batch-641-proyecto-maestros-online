class MastersController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index, :show]
    before_action :set_master, only: [:show, :edit, :update, :destroy]

  # GET /masters
  def index
    if params[:query] || params[:ubication]
      @category = Category.find_by("name ILIKE ?", "%" + params[:query] + "%")
      if @category
        @masters = Master.where("description ILIKE ?", "%#{params[:query]}%").or(Master.where(category_id: @category.id)).near(params[:ubication], 10)
      else
        @masters = Master.where("description ILIKE ?", "%#{params[:query]}%").near(params[:ubication], 10)
      end
    end
  end

  # GET /masters/1
  def show
    @markers = [{lat:@master.latitude, lng:@master.longitude}]
  end

  # GET /masters/new
  def new
     @master = Master.new
  end

  # GET /masters/1/edit
  def edit
  end

  # POST /masters
  def create
     @master = Master.new(master_params)
     @master.user = current_user

    if @master.save
      redirect_to master_path(@master)
    else
      render :new
    end
  end

  # PATCH/PUT /masters/1
  def update
    if @master.update(master_params)
      redirect_to @master
    else
      render :edit
    end
  end

  
  # DELETE /masters/1
  def destroy
    @user = @master.user
    @master.destroy
    redirect_to user_path(@user)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_master
      @master = Master.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def master_params
      params.require(:master).permit(:description, :commercial_address, :category_id, :schedule, :price_per_hour, photos: [])
    end
end

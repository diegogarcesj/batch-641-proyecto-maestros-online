class MastersController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index, :show]
    before_action :set_master, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query] && params[:query] != "" && params[:ubication] && params[:ubication] != ""
      @category = Category.find_by("name ILIKE ?", "%" + params[:query] + "%")
      if @category
        @masters = policy_scope(Master).where("description ILIKE ?", "%#{params[:query]}%").or(policy_scope(Master).where(category_id: @category.id)).near(params[:ubication], 10)
      else
        @masters = policy_scope(Master).where("description ILIKE ?", "%#{params[:query]}%").near(params[:ubication], 10)
      end
    elsif params[:query] && params[:query] != ""
      @category = Category.find_by("name ILIKE ?", "%" + params[:query] + "%")
      if @category
        @masters = policy_scope(Master).where("description ILIKE ?", "%#{params[:query]}%").or(policy_scope(Master).where(category_id: @category.id))
      else
        @masters = policy_scope(Master).where("description ILIKE ?", "%#{params[:query]}%")
      end
    elsif params[:ubication] && params[:ubication] != ""
        @masters = policy_scope(Master).near(params[:ubication], 10)
    else
        @masters = policy_scope(Master).all
    end
  end

  def show
    @markers = [{lat:@master.latitude, lng:@master.longitude}]
  end

  def new
     @master = Master.new
     authorize @master
  end

  def create
     @master = Master.new(master_params)
     @master.user = current_user
     authorize @master

    if @master.save
      redirect_to master_path(@master)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @master.update(master_params)
      redirect_to @master
    else
      render :edit
    end
  end

  def destroy
    @user = @master.user
    @master.destroy
    redirect_to user_path(@user)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_master
      @master = Master.find(params[:id])
      authorize @master
    end

    # Only allow a trusted parameter "white list" through.
    def master_params
      params.require(:master).permit(:description, :commercial_address, :category_id, :schedule, :price_per_hour, photos: [])
    end
end

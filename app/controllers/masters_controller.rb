class MastersController < ApplicationController
    before_action :set_master, only: [:show, :edit, :update, :destroy]

  # GET /masters
  def index
    @masters = Master.all
  end

  # GET /masters/1
  def show
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
      redirect_to @master, notice: 'Master was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /masters/1
  def update
    if @master.update(master_params)
      redirect_to @master, notice: 'Master was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /masters/1
  def destroy
    @master.destroy
    redirect_to masters_url, notice: 'Masters was successfully destroyed.'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_master
      @master = Master.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def master_params
      params.require(:master).permit(:description, :commercial_address, :category, :schedule, :price_per_hour, photos: [] )
    end
end

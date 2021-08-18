class OrdersController < ApplicationController
  before_action :set_master, only: [:create]
  before_action :set_order, only: [:show, :destroy]

  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(review_params)
    @order.master = @master
    @order.user = current_user

    if @order.save
      redirect_to order_path(@order)
    else
      render :new
    end

  end

  def edit
  end

  def update
  end

  def destroy
    @order.destroy

    redirect_to orders_path
  end

  private

  def set_master
    @master = Master.find(params[:master_id])
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:review).permit(:description, :date, :status)
  end
end

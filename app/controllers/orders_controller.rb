class OrdersController < ApplicationController
  before_action :set_master, only: [:show, :new, :create]
  before_action :set_order, only: [:show, :destroy]

  def index
    @orders = Order.all
  end

  def show
    @review = Review.new
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.master = @master
    @order.user = current_user
    @order.status = 0

    if @order.save
      redirect_to master_order_path(@master, @order)
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
    params.require(:order).permit(:description, :date, :status, :hours)
  end
end

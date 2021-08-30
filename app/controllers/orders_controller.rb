class OrdersController < ApplicationController
  before_action :set_master, only: [:show, :new, :create, :edit, :update, :cancel, :accept, :reject, :pay, :done]
  before_action :set_order, only: [:show, :destroy, :edit, :update]

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
    @order.update(order_params)
    @order.master = @master
    @order.user = current_user
    @order.status = 0

    if @order.save
      redirect_to master_order_path(@master, @order)
    else
      render :edit
    end
  end

  def destroy
    @order.destroy

    redirect_to orders_path
  end

  def cancel
    @order = Order.find(params[:order_id])
    @order.cancelado!
    if @order.save
      redirect_to master_order_path(@master, @order)
    else
      render :show
    end
  end

  def accept
    @order = Order.find(params[:order_id])
    @order.aceptado!
    if @order.save
      redirect_to master_order_path(@master, @order)
    else
      render :show
    end
  end

  def reject
    @order = Order.find(params[:order_id])
    @order.rechazado!
    if @order.save
      redirect_to master_order_path(@master, @order)
    else
      render :show
    end
  end

  def pay
    @order = Order.find(params[:order_id])
    @order.pagado!
    if @order.save
      redirect_to master_order_path(@master, @order)
    else
      render :show
    end
  end

  def done
    @order = Order.find(params[:order_id])
    @order.hecho!
    if @order.save
      redirect_to master_order_path(@master, @order)
    else
      render :show
    end
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

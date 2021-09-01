class OrdersController < ApplicationController
  before_action :set_master, only: [:show, :new, :create, :edit, :update, :cancel, :accept, :reject, :pay, :done]
  before_action :set_order, only: [:show, :destroy, :edit, :update]
  before_action :set_order_with_params_for_status, only: [:cancel, :accept, :reject, :pay, :done]

  def index
    @orders = Order.all
  end

  def show
    @review = Review.new
  end

  def new
    @order = Order.new
    authorize @order
  end

  def create
    @order = Order.new(order_params)
    @order.master = @master
    @order.user = current_user
    @order.status = 0
    authorize @order

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
    @order.cancelado!
    save_after_action
  end

  def accept
    @order.aceptado!
    save_after_action
  end

  def reject
    @order.rechazado!
    save_after_action
  end

  def pay
    @order.pagado!
    save_after_action
  end

  def done
    @order.hecho!
    save_after_action
  end


  private

  def set_master
    @master = Master.find(params[:master_id])
  end

  def set_order
    @order = Order.find(params[:id])
    authorize @order
  end

  def set_order_with_params_for_status
    @order = Order.find(params[:order_id])
    authorize @order
  end

  def save_after_action
    if @order.save
      redirect_to master_order_path(@master, @order)
    else
      render :show
    end
  end

  def order_params
    params.require(:order).permit(:description, :date, :status, :hours)
  end
end

class OrdersController < ApplicationController
  before_action :set_master, only: [:show, :new, :create, :edit, :update, :cancel, :accept, :reject, :pay, :done]
  before_action :set_order, only: [:show, :destroy, :edit, :update]
  before_action :set_order_with_params_for_status, only: [:cancel, :accept, :reject, :pay, :verify, :done]

  require 'khipu-api-client'

  def index
    @orders = Order.all
  end

  def show
    @review = Review.new

    @token = params["notification_token"]
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
    receiver_id = 398264
    secret_key = 'a53a4379585435ea84baf1b22c15fdfb5d933b6b'

    Khipu.configure do |c|
      c.secret = secret_key
      c.receiver_id = receiver_id
      c.platform = 'demo-maestros-online'
      c.platform_version = '2.0'
      c.debugging = true
    end

    price = @order.hours * @order.master.price_per_hour

    client = Khipu::PaymentsApi.new
    response = client.payments_post('Orden de trabajo', 'CLP', price, {
      transaction_id: 'FACT2001',
      # expires_date: Time.now + (24*60*60),
      body: @order.description,
      # picture_url: 'http://mi-ecomerce.com/pictures/foto-producto.jp',
      return_url: master_order_url(@master, @order),
      cancel_url: master_order_url(@master, @order),
      notify_url: master_order_url(@master, @order),
      notify_api_version: '1.3'
    })

    payment_id = response.payment_id
    redirect_to response.payment_url

    #@order.pagado!
    #save_after_action
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

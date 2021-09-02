class ReviewsController < ApplicationController
  before_action :set_review, only: [:destroy, :edit]
  before_action :set_master, only: [:create]
  before_action :set_order, only: [:create]

  def index
    @reviews = Review.all
  end

  def show
  end

  def new
  end

  def create
    @review = Review.new(review_params)
    @review.order = @order
    @review.user = current_user
    authorize @review

    if @review.save
      redirect_to master_order_path(@master, @order)
    else
      render 'orders/show'
    end
  end

  def edit
  end

  def update
  @review = Review.new(review_params)

    if @review.save
      redirect_to review_path(@review)
    else
      render :new
    end
  end

  def destroy
    @review.destroy

    redirect_to reviews_path
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_master
    @master = Master.find(params[:master_id])
  end

  def review_params
    params.require(:review).permit(:description, :rating)
  end
end

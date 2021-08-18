class ReviewsController < ApplicationController
  before_action :set_review, only: [:destroy, :edit]

  def index
    @reviews = Review.all
  end

  def show
  end

  def new
  end

  def create
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

  def review_params
    params.require(:review).permit(:description, :rating)
  end
end

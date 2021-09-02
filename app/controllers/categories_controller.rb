class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  def index
    @categories = policy_scope(Category)
  end

  def show
  end

  def new
    @category = Category.new
    authorize @category
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def destroy
      @category.destroy
      redirect_to categories_path
  end

  def update
      @category.update(category_params)
      redirect_to category_path(@category)
  end

  private

  def category_params
    params.require(:category).permit(:name, :photo)
  end

  def set_category
    @category = Category.find(params[:id])
    authorize @category
  end
end

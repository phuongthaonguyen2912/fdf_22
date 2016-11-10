class ProductSuggestsController < ApplicationController
  before_action :logged_in_user
  before_action :find_product_suggest, only: [:edit, :update, :destroy]
  before_action :load_categories, except: [:show, :destroy]

  def index
    @product_suggests = current_user.product_suggests.order(id: :desc)
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @product_suggest = current_user.product_suggests.build
  end

  def edit
  end

  def update
    if @product_suggest.update_attributes product_suggest_params
      flash[:success] = t "controllers.product_suggests.flash_success"
      redirect_to product_suggests_path
    else
      render :edit
    end
  end

  def create
    @product_suggest = current_user.product_suggests.build product_suggest_params
    if @product_suggest.save
      flash[:success] = t "controllers.product_suggests.create_success"
      redirect_to product_suggests_url
    else
      render :new
    end
  end

  def destroy
    if @product_suggest && @product_suggest.destroy
      flash[:success] = t "controllers.product_suggests.destroy_success"
    else
      flash[:danger] = t "controllers.product_suggests.destroy_error"
    end
    redirect_to product_suggests_url
  end

  private
  def product_suggest_params
    params.require(:product_suggest).permit :name, :price, :description, :image,
      :category_id
  end

  def find_product_suggest
    @product_suggest = ProductSuggest.find_by id: params[:id]
    unless @product_suggest
      flash[:danger] = t "controllers.product_suggests.flash_danger"
      redirect_to product_suggests_path
    end
  end

  def load_categories
    @categories = Category.all
  end
end

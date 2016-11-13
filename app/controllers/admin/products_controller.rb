class Admin::ProductsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_product, only: [:edit, :update, :destroy]
  before_action :load_categories, except: [:destroy]
  
  def index
    @products = Product.all.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t "controllers.admin.products.create.flash_success"
      redirect_to admin_products_path
    else
      flash[:danger] = t "controllers.admin.products.create.flash_danger"
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update_attributes product_params
      flash[:success] = t "controllers.admin.products.update.flash_success"
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = t "controllers.admin.products.destroy.flash_success"
    else
      flash[:danger] = t "controllers.admin.products.destroy.flash_danger"
    end
    redirect_to admin_products_path
  end

  private
  def find_product
    @product = Product.find_by id: params[:id]
    unless @product
      flash[:danger] = t "controllers.admin.products.find.flash_danger"
      redirect_to admin_products_path
    end
  end

  def product_params
    params.require(:product).permit :category_id, :name, :price,
      :description, :image
  end

  def load_categories
    @categories = Category.all
  end
end

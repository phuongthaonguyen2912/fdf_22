class ProductsController < ApplicationController
  before_action :find_product, only: :show

  def show
    @product_support = Supports::ProductSupport.new @product, params
  end

  private 
  def find_product
    @product = Product.find_by id: params[:id]
    if @product.blank?
      flash[:danger] = t "controllers.products.find_product.flash"
      redirect_to root_url
    end
  end
end

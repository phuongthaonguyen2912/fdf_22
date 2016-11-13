class ProductsController < ApplicationController
  before_action :find_product, only: :show

  def show
    @comment = Comment.new
    @comments = @product.comments.all.order_by_created_at.paginate page: params[:page],
      per_page: Settings.per_page_comment
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

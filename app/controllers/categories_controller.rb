class CategoriesController < ApplicationController
  before_action :find_category, only: :show
  
  def show
    @categories = Category.all
    @products = @category.products
  end

  private
  def find_category
    @category = Category.find_by id: params[:id]
    if @category.blank?
      flash[:danger] = t "controllers.categories.show.flash"
      redirect_to root_path
    end
  end
end

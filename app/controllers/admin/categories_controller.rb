class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_category, only: [:edit, :update, :destroy]
  before_action :load_classifies, only: [:index, :new, :edit]
  
  def index
    @categories = Category.all.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "controllers.admin.categories.create.flash_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "controllers.admin.categories.create.flash_danger"
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "controllers.admin.categories.update.flash_success"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "controllers.admin.categories.destroy.flash_success"
    else
      flash[:danger] = t "controllers.admin.categories.destroy.flash_danger"
    end
    redirect_to admin_categories_path
  end

  private
  def find_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t "controllers.admin.categories.find.flash_danger"
      redirect_to admin_categories_path
    end
  end

  def category_params
    params.require(:category).permit :name, :classify_id
  end

  def load_classifies
    @classifies = Classify.all
  end
end

class Admin::ClassifiesController < ApplicationController
 before_action :logged_in_user
  before_action :verify_admin
  before_action :find_classify, only: [:edit, :update, :destroy]
  
  def index
    @classifies = Classify.all.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @classify = Classify.new
  end

  def create
    @classify = Classify.new classify_params
    if @classify.save
      flash[:success] = t "controllers.admin.products.create.flash_success"
      redirect_to admin_classifies_path
    else
      flash[:danger] = t "controllers.admin.products.create.flash_danger"
      render :new
    end
  end

  def edit
  end

  def update
    if @classify.update_attributes classify_params
      flash[:success] = t "controllers.admin.products.update.flash_success"
      redirect_to admin_classifies_path
    else
      render :edit
    end
  end

  def destroy
    if @classify.destroy
      flash[:success] = t "controllers.admin.products.destroy.flash_success"
    else
      flash[:danger] = t "controllers.admin.products.destroy.flash_danger"
    end
    redirect_to admin_classifies_path
  end

  private
  def find_classify
    @classify = Classify.find_by id: params[:id]
    unless @classify
      flash[:danger] = t "controllers.admin.products.find.flash_danger"
      redirect_to admin_classifies_path
    end
  end

  def classify_params
    params.require(:classify).permit :name
  end
end

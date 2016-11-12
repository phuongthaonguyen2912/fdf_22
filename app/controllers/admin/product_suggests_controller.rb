class Admin::ProductSuggestsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_product_suggest, only: [:edit, :update, :destroy]
  before_action :load_status, only: :edit

  def index
    @product_suggests = ProductSuggest.order_by_time
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def edit
  end

  def update
    if @product_suggest.update_attributes product_suggest_params
      flash[:success] = t "controllers.admin.product_suggests.action_success"
      redirect_to admin_product_suggests_path
    else
      load_status
      render :edit
    end
  end

  def destroy
    if @product_suggest.destroy
      flash[:success] = t "controllers.admin.product_suggests.destroy_success"
    else
      flash[:danger] = t "controllers.admin.product_suggests.destroy_error"
    end
    redirect_to admin_product_suggests_url
  end

  private
  def product_suggest_params
    params.require(:product_suggest).permit :status
  end

  def find_product_suggest
    @product_suggest = ProductSuggest.find_by id: params[:id]
    if @product_suggest.nil?
      flash[:danger] = t "controller.admin.product_suggests.not_found"
      redirect_to admin_product_suggests_url
    end
  end

  def load_status
    @product_suggest_statuses = ProductSuggest.statuses.
      map{|key, value| [t("controllers.admin.product_suggests.#{key}"), key]}
  end
end

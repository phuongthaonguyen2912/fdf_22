class Admin::OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_order, except: [:index]
  # before_action :load_status, only: [:edit]

  def index
    @orders = Order.order_by_time
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def show
    @order_details = @order.order_items
  end

  def edit
  end

  def update
    if @order.update_attributes order_params
      flash[:success] = t "controllers.admin.orders.update_success"
      redirect_to admin_order_path(@order)
    else
      load_status
      render :edit
    end
  end

  private
  def order_params
    params.require(:order).permit :status
  end

  def find_order
    @order = Order.find_by id: params[:id]
    if @order.nil?
      flash[:danger] = t "controllers.admin.orders.not_found"
      redirect_to admin_orders_path
    end
  end

  # def load_status
  #   @order_statuses = Order.statuses.
  #     map{|key, value| [t("controllers.admin.orders.#{key}"), key]}
  # end
end

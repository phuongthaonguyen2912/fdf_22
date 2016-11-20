class OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :find_order

  def show
    @order_items = current_order.order_items
  end
  
  def update
    current_order.update_attributes status: true
    if current_order.update_attributes cart_params
      flash[:success] = t "controllers.orders.update.flash_success"
      session.delete :order_id
      redirect_to root_url
    else
      flash[:danger] = t "controllers.orders.update.flash_danger"
      redirect_to order_path current_order
    end
  end

  private
  def cart_params
    params.require(:order).permit :receiver_address,
      :order_total, :shipping_address, :shipping_date
  end

  def find_order
    if current_order.nil?
      flash[:danger] = t "controllers.orders.find_order.flash"
      redirect_to products_path
    end
  end
end

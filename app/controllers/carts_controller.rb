class CartsController < ApplicationController
  before_action :logged_in_user

  def show
    @order_items = current_order.order_items
  end

  def destroy
    current_order.destroy
    flash[:danger] = t "controllers.carts.destroy.flash_danger"
    session.delete :order_id
    redirect_to root_url
   end
end

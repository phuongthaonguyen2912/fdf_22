class OrderItemsController < ApplicationController
  before_action :logged_in_user	
  before_action :find_order

  def create
    order_item = current_order.order_items.build order_item_params
    item = current_order.order_items.find_by product_id: order_item.product_id
    if item
      item.update_attributes quantity: order_item.quantity + item.quantity
      redirect_to cart_path current_order
    else
      if order_item.save
        flash[:success] = t "controllers.order_items.create.flash_success" 
        redirect_to cart_path current_order
      else
        flash[:danger] = t "controllers.order_items.create.flash_danger" 
        redirect_to root_path
      end
    end
  end
 
  def update
    order_item = current_order.order_items.find_by id: params[:id]
    if order_item
      if order_item.update_attributes order_item_params
        flash[:success] = t "controllers.order_items.update.flash_success"
        redirect_to cart_path session[:order_id]
      else
        flash[:danger] = t "controllers.order_items.update.flash_danger"
        redirect_to cart_path session[:order_id]
      end      
    else
      flash[:danger] = t "controllers.order_items.update.flash" 
      redirect_to cart_path session[:order_id]
    end
  end
 
  def destroy
     order_item = current_order.order_items.find_by id: params[:id]
    if order_item
      order_item.destroy
      flash[:success] = t "controllers.order_items.destroy.flash_success"
    else
      flash[:danger] = t "controllers.order_items.destroy.flash_danger" 
    end
    redirect_to root_path
  end

  private
  def order_item_params
    params.require(:order_item).permit:product_id, :quantity, :price
  end 

  def find_order
    if current_order.nil?
      flash[:danger] = "controllers.order_items.find_order.flash"
      redirect_to products_path
    end
  end
end

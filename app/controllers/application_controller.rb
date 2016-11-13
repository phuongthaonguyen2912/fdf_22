class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  helper_method :current_order

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "flash.login_fails"
      redirect_to login_url
    end
  end

  def verify_admin
    unless current_user.is_admin?
      flash[:danger] = t "controllers.admin.login.flash.danger"
      redirect_to root_path
    end
  end
  
  def current_order
    if session[:order_id]
      @order = Order.find_by id: session[:order_id]
    else
      @order = current_user.orders.find_by(status: 0) || current_user.orders.create
      session[:order_id] = @order.id
    end
    @order
end

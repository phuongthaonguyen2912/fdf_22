class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin, only: [:index, :destroy]
  before_action :find_user, only: :destroy

  def index
    @users = User.paginate page: params[:page]
  end

  def destroy
    if @user.destroy
      flash[:success] = t "controllers.flash.delete_success"
    else
      flash[:danger] = t "controllers.flash.delete_error"
    end
    redirect_to admin_users_url
  end

  private
  def find_user
    @user= User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "flash.find_user_fail"
      redirect_to root_path
    end
  end
end

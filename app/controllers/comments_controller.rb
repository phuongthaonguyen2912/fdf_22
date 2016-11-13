class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create,:destroy]
  before_action :valid_comment, only: :destroy

  def create
    @product = Product.find_by id: params[:product_id]
    @comment = @product.comments.build comment_params
    if @comment.save
      respond_to do |format|
        format.js
      end
    else
      redirect_to product_path @product
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end
  
  private
  def comment_params
    params.require(:comment).permit(:product_id, :content).merge user_id: current_user.id
  end

  def valid_comment
    @comment = current_user.comments.find_by id: params[:id]
    if @comment.nil?
      flash[:danger] = t "controllers.comments.valid_comment.flash"
      redirect_to product_path @product
    end
  end
end

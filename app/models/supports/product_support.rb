class Supports::ProductSupport
  def initialize product, params
    @product = product
    @params = params
  end

  def comment
    Comment.new
  end

  def all_comment
    @product.comments.all.order_by_created_at.paginate page: @params[:page],
      per_page: Settings.per_page_comment
  end

  def order_item
    OrderItem.new
  end
end

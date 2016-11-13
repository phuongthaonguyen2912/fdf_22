class Supports::CategorySupport
  
  def initialize category
    @category = category
  end
  
   def all_category
    Category.all
   end

  # def products_category category
  #   category.products
  # end

  def products_category
    @category.products
  end

  def order_item
    OrderItem.new
  end

  def all_product
    Product.all
  end

  def newest_products
    Product.newest_product.limit Settings.newest_products
  end
end

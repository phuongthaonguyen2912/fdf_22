class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  def subtotal
   order_items.collect.sum { |oi| oi.valid? ? (oi.quantity * oi.price) : 0 }
  end
end

class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  scope :order_by_time, -> {order created_at: :desc}
  scope :is_ordered, -> {where status: true}

  def subtotal
    order_items.collect.sum {|oi| oi.valid? ? (oi.quantity * oi.price) : 0}
  end
end

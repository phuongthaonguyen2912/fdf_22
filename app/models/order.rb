class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  scope :order_by_time, -> {order created_at: :desc}

  enum status: [:waiting, :accept, :deny]

  validates :receiver_name, presence: true
  validates :shipping_address, presence: true
  validates :shipping_date, presence: true

  def subtotal
    order_items.collect.sum {|oi| oi.valid? ? (oi.quantity * oi.price) : 0}
  end
end

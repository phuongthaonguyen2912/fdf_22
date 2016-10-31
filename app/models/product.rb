class Product < ApplicationRecord
  belongs_to :category
  has_many :rates
  has_many :comments
  has_many :order_items
  has_many :orders, through: :order_items
end

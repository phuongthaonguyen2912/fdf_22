class User < ApplicationRecord
  has_many :orders
  has_many :product_suggests
  has_many :rates, dependent: :destroy
  has_many :comments, dependent: :destroy
end

class User < ApplicationRecord
  has_many :product_suggests, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :comments, dependent: :destroy
end

class Classify < ApplicationRecord
  has_many :categories, dependent: :destroy
  has_many :product_suggests, dependent: :destroy
end

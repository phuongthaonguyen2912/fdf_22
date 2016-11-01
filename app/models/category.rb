class Category < ApplicationRecord
  belongs_to :classify

  has_many :products, dependent: :destroy
end

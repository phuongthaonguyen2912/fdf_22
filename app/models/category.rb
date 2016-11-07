class Category < ApplicationRecord
  belongs_to :classify

  has_many :products, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: {maximum: 50}
end

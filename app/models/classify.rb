class Classify < ApplicationRecord
  has_many :categories, dependent: :destroy
end

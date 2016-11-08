class Product < ApplicationRecord
  belongs_to :category

  has_many :rates, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :order_items
  has_many :orders , through: :order_items

  mount_uploader :image, ImageUploader
  validates :name, presence: true
  validates :price, presence: true, numericality: {only_integer: true}
  validate :image_size

  private
  def image_size
    if image.size > Settings.size_image.megabytes
      errors.add :image, I18n.t("models/product/image_size/error")
    end
  end
end

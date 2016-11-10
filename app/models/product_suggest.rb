class ProductSuggest < ApplicationRecord
  belongs_to :user
  belongs_to :category

  mount_uploader :image, ImageUploader
  validates :name, presence: true, length: {maximum: 50}
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :description, presence: true, length: {maximum: 200}
  validates :image, presence: true, allow_nil: true
  validate :image_size

  private
  def image_size
    if image.size > Settings.size_image.megabytes
      errors.add :image, I18n.t("models.product.image_size.error")
    end
  end
end

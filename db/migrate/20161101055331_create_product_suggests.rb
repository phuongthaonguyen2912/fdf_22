class CreateProductSuggests < ActiveRecord::Migration[5.0]
  def change
    create_table :product_suggests do |t|
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.string :name
      t.integer :price
      t.string :description
      t.string :image
      t.boolean :is_approve

      t.timestamps
    end
  end
end

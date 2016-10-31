class CreateProductSuggests < ActiveRecord::Migration[5.0]
  def change
    create_table :product_suggests do |t|
      t.string :name
      t.integer :float
      t.string :description
      t.string :image
      t.boolean :is_approve
      t.references :user, foreign_key: true

      t.timestamps
    end
    change_column :product_suggests, :is_approve, :boolean, default: false
  end
end

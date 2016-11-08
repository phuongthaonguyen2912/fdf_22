class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.references :category, foreign_key: true
      t.string :name
      t.integer :price
      t.string :description
      t.string :image
      t.float :avg_rate, default: 0.0
      t.boolean :status

      t.timestamps
    end
  end
end

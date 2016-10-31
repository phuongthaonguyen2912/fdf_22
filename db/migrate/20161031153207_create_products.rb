class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :image
      t.integer :price
      t.string :description
      t.boolean :status
      t.float :avg_rate
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :products, :name, unique: true
    change_column :products, :status, :boolean, default: true
  end
end

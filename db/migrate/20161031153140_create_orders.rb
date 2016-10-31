class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :shipping_address
      t.datetime :shipping_date
      t.boolean :status
      t.integer :order_total
      t.references :user, foreign_key: true

      t.timestamps
    end
    change_column :orders, :status, :boolean, default: false
  end
end

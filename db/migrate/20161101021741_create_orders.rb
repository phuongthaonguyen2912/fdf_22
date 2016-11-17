class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.string :receiver_name
      t.integer :status, default: 0
      t.integer :order_total
      t.string :shipping_address
      t.datetime :shipping_date

      t.timestamps
    end
  end
end

class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.boolean :status
      t.integer :order_total
      t.string :shipping_address
      t.datetime :shipping_date

      t.timestamps
    end
  end
end

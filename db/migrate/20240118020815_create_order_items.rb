class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.integer :item_id, null: false
      t.integer :order_id, null: false
      t.integer :price, null: false
      t.integer :quantity, null: false
      t.integer :product_status, default: 0, null: false
      t.timestamps
    end
  end
end

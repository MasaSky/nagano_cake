class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.string :attention, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.integer :freight, default: 800, null: false
      t.integer :grand_total, null: false
      t.integer :payment_method, default: 0, null: false
      t.integer :order_status, default: 0, null: false
      t.timestamps
    end
  end
end

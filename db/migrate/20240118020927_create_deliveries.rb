class CreateDeliveries < ActiveRecord::Migration[6.1]
  def change
    create_table :deliveries do |t|
      t.integer :customer_id, null: false
      t.string :attention, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.timestamps
    end
  end
end

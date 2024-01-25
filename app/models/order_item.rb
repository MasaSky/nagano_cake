class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum product_status: {"着手不可": 0, "製作待ち": 1, "製作中": 2, "製作完了": 3}

  def subtotal
    quantity * item.price
  end

  def self.total_amount(order)
    OrderItem.where(order_id: order.id).inject(0){|sum, order_item| sum + order_item.subtotal}
  end

end
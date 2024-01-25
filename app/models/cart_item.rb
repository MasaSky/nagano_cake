class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  validates :customer_id, :item_id, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true }

  def subtotal
    quantity * item.price
  end

  def quantity_options
    options = []
    ((self.quantity || 0) + 10).times do |count|
      options << [count, count]
    end
    return options
  end

  def self.total_amount(customer)
    CartItem.where(customer_id: customer.id).inject(0){|sum, cart_item| sum + cart_item.subtotal}
  end

end

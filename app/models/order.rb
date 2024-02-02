class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items
  has_many :items, through: :order_items

  enum payment_method: {"クレジットカード": 0, "銀行振込": 1}
  enum order_status: {"入金待ち": 0, "入金確認": 1, "製作中": 2, "発送準備中": 3, "発送済み": 4}
  validates :attention, presence: true, length: { minimum: 2, maximum: 20 }
  validates :postal_code, presence: true, length: { is: 7 }, numericality: { only_integer: true }
  validates :address, presence: true, length: { minimum: 7, maximum: 150 }

  def delivery_form(resource)
    class_name = resource.class.name
    if class_name == 'Customer'
      self.postal_code = resource.postal_code
      self.address = resource.address
      self.attention = resource.full_name
    elsif class_name == 'Delivery'
      self.postal_code = resource.postal_code
      self.address = resource.address
      self.attention = resource.attention
    end
  end

  def create_order_items(customer)
    unless order_items.first
      cart_items = customer.cart_items.includes(:item)
      cart_items.each do |cart_item|
        item = cart_item.item
        OrderItem.create!(
          order_id: id,
          item_id: item.id,
          price: item.price,
          quantity: cart_item.quantity
        )
      end
      cart_items.destroy_all
    end
  end


end
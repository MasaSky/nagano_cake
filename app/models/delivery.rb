class Delivery < ApplicationRecord
  belongs_to :customer

  validates :attention, presence: true, length: { minimum: 2, maximum: 20 }
  validates :postal_code, presence: true, length: { is: 7 }, numericality: { only_integer: true }
  validates :address, presence: true, length: { minimum: 7, maximum: 150 }

  def order_address
	self.postal_code + self.address + self.attention
  end
end

class Item < ApplicationRecord
  belongs_to :genre
	has_one_attached :image
	has_many :cart_items
	has_many :orders, through: :order_details
	has_many :order_items

  validates :genre_id, :name, :unit_price, presence: true
	validates :introduction, length: { maximum: 200 }, presence: true
	validates :unit_price, numericality: { only_integer: true }

	def self.looks(word)
		@item = Item.where("name LIKE?","%#{word}%")
	end
end

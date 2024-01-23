class Item < ApplicationRecord
  belongs_to :genre
  has_one_attached :image
  has_many :cart_items
  has_many :orders
  has_many :order_items

  validates :genre_id, :name, :unit_price, presence: true
  validates :introduction, length: { maximum: 200 }, presence: true
  validates :unit_price, numericality: { only_integer: true }

  def self.ransackable_attributes(auth_object = nil)
    %w[name introduction]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end

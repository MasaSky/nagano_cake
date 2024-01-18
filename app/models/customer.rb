class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :deliveries, dependent: :destroy

  validates :last_name, :first_name, :last_name_kana, :first_name_kana, :address, :telphone_number, presence: true
  validates :postal_code, length: { is: 7 }, numericality: { only_integer: true }
  validates :telphone_number, length: { in: 10..11 }, numericality: { only_integer: true }
  validates :last_name_kana, :first_name_kana, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: "カタカナで入力して下さい。"}

  def active_for_authentication?
    super && (self.is_deleted == false)
  end

  def self.looks(word)
    @customer = Customer.where("last_name LIKE?","%#{word}%")
  end
end

class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :deliveries, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: "カタカナで入力して下さい。"}
  validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: "カタカナで入力して下さい。"}
  validates :address, presence: true
  validates :postal_code, presence: true, length: { is: 7 }, numericality: { only_integer: true }
  validates :telphone_number, presence: true, length: { in: 10..11 }, numericality: { only_integer: true }

  def active_for_authentication?
    super && (is_active == true)
  end
	
  def full_name
    first_name + " " + last_name
  end

  def address_display
	  "〒#{postal_code}" + address + last_name + first_name
  end

  def self.looks(word)
    @customer = Customer.where("last_name LIKE?","%#{word}%")
  end
end

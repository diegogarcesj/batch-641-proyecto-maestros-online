class Master < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :orders
  has_many :reviews, through: :orders

  has_many_attached :photos

  validates :description, presence: true
  validates :commercial_address, presence: true
  validates :schedule, presence: true
  validates :price_per_hour, presence: true
  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :photos, presence: true, length: { minimum: 1, maximum: 3 }
end

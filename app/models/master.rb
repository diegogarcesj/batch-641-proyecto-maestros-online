class Master < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :orders

  has_many_attached :photos
  #has_many :reviews, :through :orders
end

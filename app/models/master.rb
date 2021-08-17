class Master < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :orders
end

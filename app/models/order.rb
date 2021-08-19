class Order < ApplicationRecord
  belongs_to :user
  belongs_to :master
  has_many :reviews
end

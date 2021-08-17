class Order < ApplicationRecord
  belongs_to :user
  belongs_to :master
  belongs_to :review
end

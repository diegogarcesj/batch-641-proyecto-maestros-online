class Order < ApplicationRecord
  belongs_to :user
  belongs_to :master
  has_many :reviews, dependent: :destroy

  validates :description, presence: true
  validates :date, presence: true
  validates :status, presence: true
  validates :user_id, presence: true
  validates :master_id, presence: true
end

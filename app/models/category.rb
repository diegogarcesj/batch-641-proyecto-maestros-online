class Category < ApplicationRecord
    has_many :masters

    has_one_attached :photo

    validates :name, presence: true, uniqueness: true
    validates :photo, presence: true
end

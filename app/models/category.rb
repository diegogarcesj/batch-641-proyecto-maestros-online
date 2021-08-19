class Category < ApplicationRecord
    has_many :masters

    has_one_attached :photo
end

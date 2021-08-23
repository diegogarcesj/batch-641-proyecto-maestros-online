class Review < ApplicationRecord
  belongs_to :order
  belongs_to :user

  validates :description, presence: true
  # validates :rating, presence: true # Esto no lo usamos, porque solo cuando el trabajo esta terminado aparece la opción de la estrellas.
  validates :order_id, presence: true
  validates :user_id, presence: true
end

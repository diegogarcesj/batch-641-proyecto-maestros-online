class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :master
  has_many :orders
  has_many :reviews

  has_one_attached :photo

  def full_name
   "#{try(:first_name)} #{try(:last_name)}".to_s
  end
end

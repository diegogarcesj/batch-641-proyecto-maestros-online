class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :master, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_one_attached :photo

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  before_validation :strip_email

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name, uniqueness: { scope: :last_name }
  validates :address, presence: true
  validates :phone, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A.+@.+\..+\z/ }
  validates :photo, presence: true

  def full_name
   "#{try(:first_name)} #{try(:last_name)}".to_s
  end

  private

  def strip_email
    self.email = email.strip unless email.nil?
  end
end

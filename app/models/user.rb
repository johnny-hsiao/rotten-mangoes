class User < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_secure_password

  validates :email, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :password, presence: true, length: { in: 6..20 }, on: :create
  validates :password_confirmation, presence: true

  def full_name
    "#{firstname} #{lastname}"
  end
end

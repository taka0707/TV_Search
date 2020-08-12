class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tv_schedules

  with_options presence: true do
    validates :name
    validates :email
    validates :password
  end
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 }, confirmation: true
  validates :password_confirmation, presence: true
end

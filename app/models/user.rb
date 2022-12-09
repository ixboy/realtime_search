class User < ApplicationRecord
  has_many :articles, dependent: :destroy

  validates :email, presence: true,
                    format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'must be a valid email address' }, uniqueness: true

  validates :password, length: { minimum: 6 }, presence: true
  validates :password_confirmation, length: { minimum: 6 }, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

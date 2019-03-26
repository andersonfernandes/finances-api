class User < ApplicationRecord
  has_secure_password

  has_and_belongs_to_many :categories

  validates :name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end

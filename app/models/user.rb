# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  name            :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  has_secure_password

  has_many :categories, dependent: :delete_all
  has_many :accounts, dependent: :delete_all
  has_many :tokens, dependent: :delete_all

  has_one :refresh_token, dependent: :delete

  validates :name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def default_account
    accounts.where(default: true).take
  end
end

# == Schema Information
#
# Table name: reserves
#
#  id             :bigint(8)        not null, primary key
#  current_amount :decimal(, )      default(0.0)
#  description    :string
#  initial_amount :decimal(, )      default(0.0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  account_id     :bigint(8)        not null
#
# Indexes
#
#  index_reserves_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Reserve < ApplicationRecord
  belongs_to :account
  has_many :reserve_activities
  has_many :activities, through: :reserve_activities

  validates :initial_amount, :description, presence: true
  validates :current_amount, :initial_amount, numericality: true
end

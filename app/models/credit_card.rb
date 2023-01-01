# == Schema Information
#
# Table name: credit_cards
#
#  id          :bigint(8)        not null, primary key
#  billing_day :integer          not null
#  limit       :decimal(, )      not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint(8)        not null
#
# Indexes
#
#  index_credit_cards_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class CreditCard < ApplicationRecord
  belongs_to :user
  has_many :credit_card_activities
  has_many :activities, through: :credit_card_activities

  validates :name, :billing_day, :limit, presence: true
  validates :limit, numericality: true
  validates :billing_day, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 31
  }

  def to_response
    as_json(only: %i[id name limit billing_day])
  end
end

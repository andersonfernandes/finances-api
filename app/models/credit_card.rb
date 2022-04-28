# == Schema Information
#
# Table name: credit_cards
#
#  id          :bigint(8)        not null, primary key
#  closing_day :integer          not null
#  due_day     :integer          not null
#  limit       :decimal(, )      not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :bigint(8)        not null
#
# Indexes
#
#  index_credit_cards_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class CreditCard < ApplicationRecord
  belongs_to :account

  # validates :name, :closing_day, :due_day, :limit, presence: true
  # validates :limit, numericality: true
  # validates :closing_day, :due_day, numericality: {
  #   only_integer: true,
  #   greater_than_or_equal_to: 1,
  #   less_than_or_equal_to: 31
  # }

  delegate :to_response, to: :account, prefix: true

  def to_response
    as_json(only: %i[id name limit closing_day due_day]).merge('account' => account_to_response)
  end
end

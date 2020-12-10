# == Schema Information
#
# Table name: transactions
#
#  id               :bigint(8)        not null, primary key
#  amount           :decimal(, )      not null
#  description      :string           not null
#  spent_at         :date             not null
#  transaction_type :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  account_id       :bigint(8)        not null
#  category_id      :bigint(8)
#
# Indexes
#
#  index_transactions_on_account_id   (account_id)
#  index_transactions_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (category_id => categories.id)
#

class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :category

  enum transaction_type: %i[income expense transfer]

  validates :amount, numericality: true
  validates :amount, :description, :transaction_type, :spent_at, presence: true

  delegate :id, :description, :to_response, to: :category, prefix: true
  delegate :id, :to_response, to: :account, prefix: true

  def to_response
    exposed_fields = %i[id
                        description
                        amount
                        transaction_type]
    as_json(only: exposed_fields)
      .merge('category' => category_to_response,
             'account' => account_to_response,
             'spent_at' => spent_at.to_time.iso8601)
  end
end

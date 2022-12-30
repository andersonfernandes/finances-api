# == Schema Information
#
# Table name: credit_card_transactions
#
#  id             :bigint(8)        not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  credit_card_id :bigint(8)        not null
#  transaction_id :bigint(8)        not null
#
# Indexes
#
#  index_credit_card_transactions_on_credit_card_id  (credit_card_id)
#  index_credit_card_transactions_on_transaction_id  (transaction_id)
#
# Foreign Keys
#
#  fk_rails_...  (credit_card_id => credit_cards.id)
#  fk_rails_...  (transaction_id => transactions.id)
#
class CreditCardTransaction < ApplicationRecord
  belongs_to :credit_card
  belongs_to :transaction
end

# == Schema Information
#
# Table name: reserve_transactions
#
#  id             :bigint(8)        not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  reserve_id     :bigint(8)        not null
#  transaction_id :bigint(8)        not null
#
# Indexes
#
#  index_reserve_transactions_on_reserve_id      (reserve_id)
#  index_reserve_transactions_on_transaction_id  (transaction_id)
#
# Foreign Keys
#
#  fk_rails_...  (reserve_id => reserves.id)
#  fk_rails_...  (transaction_id => transactions.id)
#
class ReserveTransaction < ApplicationRecord
  belongs_to :reserve
  belongs_to :transaction
end

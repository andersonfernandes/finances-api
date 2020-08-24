# == Schema Information
#
# Table name: accounts
#
#  id                    :bigint(8)        not null, primary key
#  account_type          :integer          not null
#  description           :string
#  financial_institution :string           not null
#  initial_amount        :decimal(, )      default(0.0), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_id               :bigint(8)        not null
#
# Indexes
#
#  index_accounts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Account < ApplicationRecord
  belongs_to :user

  validates :initial_amount, numericality: true
  validates(:account_type, :financial_institution, :initial_amount,
            presence: true)

  enum account_type: %i[checking savings other]

  def to_response
    as_json(
      only: %i[id description financial_institution initial_amount account_type]
    )
  end
end

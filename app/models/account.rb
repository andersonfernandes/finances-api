# == Schema Information
#
# Table name: accounts
#
#  id                       :bigint(8)        not null, primary key
#  account_type             :integer          not null
#  description              :string
#  initial_amount           :decimal(, )      default(0.0), not null
#  name                     :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  financial_institution_id :bigint(8)        not null
#  user_id                  :bigint(8)        not null
#
# Indexes
#
#  index_accounts_on_financial_institution_id  (financial_institution_id)
#  index_accounts_on_user_id                   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (financial_institution_id => financial_institutions.id)
#  fk_rails_...  (user_id => users.id)
#
class Account < ApplicationRecord
  belongs_to :user
  belongs_to :financial_institution

  validates(:initial_amount, numericality: true)
  validates(:account_type, :initial_amount, presence: true)

  enum account_type: %i[checking savings other]

  delegate :id, :name, :logo_url, to: :financial_institution, prefix: true

  def to_response
    attrs_to_expose = %i[id description name financial_institution initial_amount account_type]
    as_json(only: attrs_to_expose,
            include: { financial_institution: { only: %i[id name logo_url] } })
  end
end

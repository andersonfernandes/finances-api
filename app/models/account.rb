# == Schema Information
#
# Table name: accounts
#
#  id                       :bigint(8)        not null, primary key
#  description              :string
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

  delegate :id, :name, :logo_url, to: :financial_institution, prefix: true

  def to_response
    attrs_to_expose = %i[id description name financial_institution initial_amount]
    as_json(only: attrs_to_expose,
            include: { financial_institution: { only: %i[id name logo_url] } })
  end
end

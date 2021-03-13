# == Schema Information
#
# Table name: financial_institutions
#
#  id         :bigint(8)        not null, primary key
#  logo_url   :string
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class FinancialInstitution < ApplicationRecord
  validates :name, presence: true

  def to_response
    as_json(only: %i[id name logo_url])
  end
end

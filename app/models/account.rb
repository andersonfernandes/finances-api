# == Schema Information
#
# Table name: accounts
#
#  id          :bigint(8)        not null, primary key
#  default     :boolean          default(FALSE)
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint(8)        not null
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
  has_many :reserves, class_name: 'Reserve'

  validates :name, presence: true
  validate :validate_unique_default_per_user

  def to_response
    attrs_to_expose = %i[id description name]
    as_json(only: attrs_to_expose)
  end

  private

  def validate_unique_default_per_user
    message = 'The user already have an default Account'
    is_invalid = default && user&.default_account && user&.default_account != self

    errors.add(:default, :not_unique, message: message) if is_invalid
  end
end

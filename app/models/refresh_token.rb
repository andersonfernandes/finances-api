# == Schema Information
#
# Table name: refresh_tokens
#
#  id         :bigint(8)        not null, primary key
#  revoked_at :datetime
#  status     :integer          not null
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)        not null
#
# Indexes
#
#  index_refresh_tokens_on_token    (token) UNIQUE
#  index_refresh_tokens_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class RefreshToken < ApplicationRecord
  belongs_to :user

  enum status: %i[active revoked]

  validates :token, uniqueness: true, allow_nil: false
  validates :token, :status, presence: true
end

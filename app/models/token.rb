# == Schema Information
#
# Table name: tokens
#
#  id         :bigint(8)        not null, primary key
#  expiry_at  :datetime         not null
#  status     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  jwt_id     :string           not null
#  user_id    :bigint(8)        not null
#
# Indexes
#
#  index_tokens_on_jwt_id   (jwt_id) UNIQUE
#  index_tokens_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Token < ApplicationRecord
  belongs_to :user

  enum status: %i[active revoked]

  validates :jwt_id, :status, :expiry_at, presence: true
  validates :jwt_id, uniqueness: true
end

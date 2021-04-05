# == Schema Information
#
# Table name: refresh_tokens
#
#  id              :bigint(8)        not null, primary key
#  encrypted_token :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint(8)        not null
#
# Indexes
#
#  index_refresh_tokens_on_encrypted_token  (encrypted_token) UNIQUE
#  index_refresh_tokens_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class RefreshToken < ApplicationRecord
  belongs_to :user

  validates :encrypted_token, uniqueness: true, allow_nil: false

  before_create :generate_encrypted_token

  private

  def generate_encrypted_token
    self.encrypted_token = Digest::SHA256.hexdigest(SecureRandom.hex)
  end
end

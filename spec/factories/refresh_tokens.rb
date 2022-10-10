FactoryBot.define do
  factory :refresh_token do
    encrypted_token { Digest::SHA256.hexdigest(SecureRandom.hex) }
    user { build(:user) }
  end
end

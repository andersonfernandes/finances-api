FactoryBot.define do
  factory :token do
    jwt_id { Digest::SHA256.hexdigest(SecureRandom.hex) }
    expiry_at { 2.days.from_now }
    status { :active }
    user { build(:user) }
  end
end

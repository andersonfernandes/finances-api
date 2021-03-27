FactoryBot.define do
  factory :refresh_token do
    encrypted_token { Faker::Crypto.sha256 }
    user { build(:user) }
  end
end

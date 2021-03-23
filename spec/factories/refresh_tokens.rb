FactoryBot.define do
  factory :refresh_token do
    token { Faker::Crypto.sha256 }
    status { :active }
    revoked_at { nil }
    user { build(:user) }
  end
end

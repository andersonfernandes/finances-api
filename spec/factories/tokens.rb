FactoryBot.define do
  factory :token do
    jwt_id { Faker::Crypto.sha256 }
    expiry_at { Faker::Time.forward(days: 1, period: :morning) }
    status { :active }
    user { build(:user) }
  end
end

FactoryBot.define do
  factory :activity do
    description { FFaker::Lorem.sentences.first }
    amount { FFaker::Number.decimal }
    paid_at { 1.day.ago }
    expires_at { 10.days.from_now }
    recurrent { false }
    origin { :reserve }

    user { FactoryBot.build(:user) }
    category { FactoryBot.build(:category) }
  end
end

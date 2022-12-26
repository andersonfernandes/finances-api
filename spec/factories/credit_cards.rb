FactoryBot.define do
  factory :credit_card do
    name { FFaker::Name.name }
    limit { FFaker::Number.decimal }
    billing_day { rand(1..30) }
    user { FactoryBot.build(:user) }
  end
end

FactoryBot.define do
  factory :expense do
    description { Faker::Lorem.sentence(3, true) }
    amount { Faker::Number.decimal(2, 2) }
    payment_method { :debit }
    spent_on { Faker::Date.backward(1) }

    user { FactoryBot.build(:user) }
    category { FactoryBot.build(:category) }
  end
end

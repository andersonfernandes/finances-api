FactoryBot.define do
  factory :expense do
    description { Faker::Lorem.sentence(3, true) }
    amount { Faker::Number.decimal(2, 2) }
    payment_methodend { :debit }
    spent_on { Faker::Date.backward(1) }
  end
end

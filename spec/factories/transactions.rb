FactoryBot.define do
  factory :transaction do
    description { Faker::Lorem.sentence(word_count: 3, supplemental: true) }
    amount { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    payment_method { :debit }
    spent_on { Faker::Date.backward(days: 1) }

    user { FactoryBot.build(:user) }
    category { FactoryBot.build(:category) }
  end
end

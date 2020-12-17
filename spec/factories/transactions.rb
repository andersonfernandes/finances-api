FactoryBot.define do
  factory :transaction do
    description { Faker::Lorem.sentence(word_count: 3, supplemental: true) }
    amount { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    transaction_type { :expense }
    spent_at { Faker::Date.backward(days: 1) }

    account { FactoryBot.build(:account) }
    category { FactoryBot.build(:category) }
  end
end

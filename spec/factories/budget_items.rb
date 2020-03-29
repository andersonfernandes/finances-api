FactoryBot.define do
  factory :budget_item do
    description { Faker::Lorem.sentence(word_count: 3, supplemental: true) }
    amount { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    min_amount { Faker::Number.decimal(l_digits: 2, r_digits: 2) }

    budget { FactoryBot.build(:budget) }
    category { FactoryBot.build(:category) }
  end
end

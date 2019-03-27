FactoryBot.define do
  factory :budget_item do
    description { Faker::Lorem.sentence(3, true) }
    amount { Faker::Number.decimal(2, 2) }
    min_amount { Faker::Number.decimal(2, 2) }

    budget { FactoryBot.build(:budget) }
    category { FactoryBot.build(:category) }
  end
end

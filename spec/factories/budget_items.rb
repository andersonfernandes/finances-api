FactoryBot.define do
  factory :budget_item do
    description { FFaker::Lorem.sentences.first }
    amount { FFaker::Number.decimal }
    min_amount { FFaker::Number.decimal }

    budget { FactoryBot.build(:budget) }
    category { FactoryBot.build(:category) }
  end
end

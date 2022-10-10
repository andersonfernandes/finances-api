FactoryBot.define do
  factory :transaction do
    description { FFaker::Lorem.sentences.first }
    amount { FFaker::Number.decimal }
    transaction_type { :expense }
    spent_at { 1.day.ago }

    account { FactoryBot.build(:account) }
    category { FactoryBot.build(:category) }
  end
end

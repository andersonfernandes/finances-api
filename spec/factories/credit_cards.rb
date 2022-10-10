FactoryBot.define do
  factory :credit_card do
    name { FFaker::Name.name }
    limit { FFaker::Number.decimal }
    closing_day { rand(1..30) }
    due_day { rand(1..30) }
    account { FactoryBot.build(:account) }
  end
end

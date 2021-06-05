FactoryBot.define do
  factory :credit_card do
    name { Faker::Name.name }
    limit { Faker::Number.decimal(l_digits: 3, r_digits: 3) }
    closing_day { Faker::Number.between(from: 1, to: 30) }
    due_day { Faker::Number.between(from: 1, to: 30) }
    account { FactoryBot.build(:account) }
  end
end

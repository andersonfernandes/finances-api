FactoryBot.define do
  factory :account do
    account_type { Account.account_types.values.sample }
    description { Faker::Lorem.sentence(word_count: 3, supplemental: true) }
    name { Faker::Lorem.sentence(word_count: 1, supplemental: true) }
    financial_institution { Faker::Company.name }
    initial_amount { Faker::Commerce.price }
    user { FactoryBot.build(:user) }
  end
end

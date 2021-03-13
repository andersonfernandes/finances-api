FactoryBot.define do
  factory :account do
    account_type { Account.account_types.values.sample }
    description { Faker::Lorem.sentence(word_count: 3, supplemental: true) }
    name { Faker::Lorem.sentence(word_count: 1, supplemental: true) }
    initial_amount { Faker::Commerce.price }

    user { FactoryBot.build(:user) }
    financial_institution { FactoryBot.build(:financial_institution) }
  end
end

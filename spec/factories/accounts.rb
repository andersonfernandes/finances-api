FactoryBot.define do
  factory :account do
    account_type { Account.account_types.values.sample }
    description { FFaker::Lorem.sentences.first }
    name { FFaker::Lorem.sentences.first }
    initial_amount { FFaker::Number.decimal }

    user { FactoryBot.build(:user) }
    financial_institution { FactoryBot.build(:financial_institution) }
  end
end

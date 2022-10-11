FactoryBot.define do
  factory :account do
    description { FFaker::Lorem.sentences.first }
    name { FFaker::Lorem.sentences.first }

    user { FactoryBot.build(:user) }
  end
end

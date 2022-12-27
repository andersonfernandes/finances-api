FactoryBot.define do
  factory :reserve do
    description { FFaker::Lorem.sentences.first }
    initial_amount { 100.0 }
    current_amount { 0.0 }
    account { FactoryBot.build(:account) }
  end
end

FactoryBot.define do
  factory :budget do
    description { FFaker::Lorem.sentences.first }
    user { FactoryBot.build(:user) }
  end
end

FactoryBot.define do
  factory :budget do
    description { Faker::Lorem.sentence(word_count: 3, supplemental: true) }
    user { FactoryBot.build(:user) }
  end
end

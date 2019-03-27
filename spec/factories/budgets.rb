FactoryBot.define do
  factory :budget do
    description { Faker::Lorem.sentence(3, true) }
    user { FactoryBot.build(:user) }
  end
end

FactoryBot.define do
  factory :category do
    description { Faker::Lorem.sentence(3, true) }

    user { FactoryBot.build(:user) }
  end
end

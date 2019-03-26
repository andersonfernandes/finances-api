FactoryBot.define do
  factory :category do
    description { Faker::Lorem.sentence(3, true) }
  end
end

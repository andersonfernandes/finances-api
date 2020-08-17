FactoryBot.define do
  factory :category do
    description { Faker::Lorem.sentence(word_count: 3, supplemental: true) }
    user { FactoryBot.build(:user) }
    parent_category { nil }
    child_categories { [] }
  end
end

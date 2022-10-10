FactoryBot.define do
  factory :category do
    description { FFaker::Lorem.sentences.first }
    user { FactoryBot.build(:user) }
    parent_category { nil }
    child_categories { [] }
  end
end

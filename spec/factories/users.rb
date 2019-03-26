FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email  { Faker::Internet.email }
    password { Faker::Internet.password }

    categories { [FactoryBot.build(:category)] }
  end
end

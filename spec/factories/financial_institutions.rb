FactoryBot.define do
  factory :financial_institution do
    name { Faker::Company.name }
    logo_url { Faker::Internet.url }
  end
end

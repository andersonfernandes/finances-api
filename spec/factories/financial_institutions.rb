FactoryBot.define do
  factory :financial_institution do
    name { FFaker::Company.name }
    logo_url { FFaker::InternetSE.http_url }
  end
end

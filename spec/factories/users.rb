FactoryBot.define do
  factory :user do
    username { Faker::Pokemon.unique.name }
    password { Faker::MichaelScott.quote }
  end
end

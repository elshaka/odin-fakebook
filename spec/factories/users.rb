FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    bio { Faker::Movie.quote }
    password { 'password' }
    password_confirmation { 'password' }
  end
end

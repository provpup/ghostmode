require 'factory_girl'

FactoryGirl.define do
  factory :route do
    name  Faker::Address.street_name
  end
end

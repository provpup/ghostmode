require 'factory_girl'

FactoryGirl.define do
  factory :user do
    username  Faker::Internet.email
    password  Faker::Internet.password
  end
end

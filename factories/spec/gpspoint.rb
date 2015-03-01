require 'factory_girl'

FactoryGirl.define do
  factory :gps_point do
    longitude Faker::Address.longitude
    latitude  Faker::Address.latitude
  end
end

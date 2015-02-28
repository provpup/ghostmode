require 'factory_girl'

FactoryGirl.define do
  factory :user do
    username  Faker::Internet.email
    password  Faker::Internet.password
  end
end

# FactoryGirl.define do
#   factory :book do
#     library
#     title     Faker::Commerce.product_name
#     author    Faker::Name.name
#     abstract  Faker::Company.bs
#     pages     100 
#     isbn      Faker::Code.isbn
#   end
# end
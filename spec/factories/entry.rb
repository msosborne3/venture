require 'faker'

FactoryGirl.define do
  factory :entry do
    title { Faker::Name.first_name }
    content { Faker::Lorem.paragraph }
    
    association :user
  end
end
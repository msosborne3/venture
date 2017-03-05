require 'faker'

FactoryGirl.define do
  factory :entry do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    
    association :user
  end
end
require 'faker'

FactoryGirl.define do
  factory :place do
    name { Faker::Lorem.words }
    
    association :user
  end
end
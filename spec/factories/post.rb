require 'faker'

FactoryGirl.define do
  factory :post do
    link { Faker::Internet.url }
    description { Faker::Lorem.sentence }

    association :place
  end
end
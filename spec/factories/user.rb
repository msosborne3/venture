require 'faker'

FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(8) }

    factory :facebook_user do
      provider {  Faker::Omniauth.facebook[:provider] }
      uid { Faker::Omniauth.facebook[:uid] }
      first_name { Faker::Omniauth.facebook[:info][:first_name] }
      last_name { Faker::Omniauth.facebook[:info][:last_name] }
      email { Faker::Omniauth.facebook[:info][:email] }
      password 'password'
    end
  end
end
FactoryGirl.define do
  factory :user do
    sequence(:first_name) {|i| "FirstName#{i}"}
    sequence(:last_name) {|i| "LastName#{i}"}
    sequence(:email) {|i| "test#{i}@example.com"}
    password "secret"
  end
end
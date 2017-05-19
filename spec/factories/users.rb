FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name "Doe"
    password "password"
    password_confirmation "password"
    email "john@doe.com"
  end
end

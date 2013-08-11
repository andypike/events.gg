# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Joe Bloggs"
    email "joe@bloggs.com"
    password "secret"
    password_confirmation "secret"
    time_zone "London"
  end
end

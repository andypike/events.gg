# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Joe Bloggs"
    sequence :email do |n|
      "email#{n}@factory.com"
    end
    password "secret"
    password_confirmation "secret"
    time_zone "London"
    role "normal"

    factory :admin do
      role "admin"
    end
  end
end

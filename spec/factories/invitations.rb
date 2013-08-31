# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    user_id 1
    organisation_id 1
    status "invited"
    role "member"
  end
end

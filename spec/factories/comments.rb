FactoryGirl.define do
  factory :comment do

    body "text"

    association :event
    association :user
  end
end
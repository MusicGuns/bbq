FactoryGirl.define do
  factory :subscription do

    association :event
    association :user
  end
end
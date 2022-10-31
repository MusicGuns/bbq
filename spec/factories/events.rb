FactoryGirl.define do
  factory :event do
    title "Идем пить пиво"
    address "Балашиха"

    password "123"

    datetime Time.now

    association :user
  end
end

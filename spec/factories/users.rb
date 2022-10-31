FactoryGirl.define do
  factory :user do

    email { "some#{rand(999)}@mail.ru" }
    password "skmsmk"
  end
end
FactoryGirl.define do
  factory :photo do

    photo { Rack::Test::UploadedFile.new('spec/fixtures/1.jpg') }

    association :event
    association :user
  end
end
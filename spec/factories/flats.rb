require 'faker'
FactoryGirl.define do
  factory :flat do |f|
    f.name Faker::Lorem.word
  end
end

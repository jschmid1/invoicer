require 'faker'
FactoryGirl.define do
  factory :bill do |f|
    f.value Faker::Number.number(2)
    f.user_id Faker::Number.digit
    f.market_id Faker::Number.digit
  end
end

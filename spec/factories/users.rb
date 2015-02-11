require 'faker'
FactoryGirl.define do
  factory :user do |u|
    u.name Faker::Name.first_name
    u.email Faker::Internet.email
    u.password "12345678"
    u.password_confirmation "12345678"
  end
end

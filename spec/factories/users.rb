require 'faker'
FactoryGirl.define do
  factory :user do |u|
    u.name "test"
    u.email "jeff@test.com"
    u.password "12345678"
    u.password_confirmation "12345678"
  end
end

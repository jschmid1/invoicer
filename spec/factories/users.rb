require_relative '../rails_helper'
require 'faker'
FactoryGirl.define do
  factory :user do |u|
    u.name {Faker::Name.first_name} 
    u.email "jeff@test.com"
    u.password "testtesttest"
    u.password_confirmation "testtesttest"
  end
end

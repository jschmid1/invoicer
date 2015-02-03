class Event < ActiveRecord::Base
  has_one :creator, class_name: "User"
  has_and_belongs_to_many :users
end

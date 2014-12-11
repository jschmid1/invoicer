class Flat < ActiveRecord::Base
  has_many :users
  has_many :invites
end

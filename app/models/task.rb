class Task < ActiveRecord::Base
  belongs_to :flat
  has_and_belongs_to_many :users
end

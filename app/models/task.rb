class Task < ActiveRecord::Base
  belongs_to :flat
  has_many :working_on_tasks
  has_many :users, :through => :working_on_tasks
  #has_and_belongs_to_many :users, :join_table => "tasks_users"
end

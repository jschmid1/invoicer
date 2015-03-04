class Task < ActiveRecord::Base
  validates :name, presence: true
  validates :credit, presence: true
  validates :flat_id, presence: true
  belongs_to :flat
  has_many :working_on_tasks
  has_many :users, :through => :working_on_tasks
end

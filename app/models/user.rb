class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  require 'yaml'
  after_create :user_task_entry
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :bills
  belongs_to :flat
  has_many :invitations, :class_name => "Invite", :foreign_key => 'recipient_id'
  has_many :sent_invites, :class_name => "Invite", :foreign_key => 'sender_id'
  has_many :working_on_tasks
  has_many :tasks, :through => :working_on_tasks
  has_and_belongs_to_many :users, :join_table => "tasks_users"

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def user_task_entry
    file = 'config/user_tasks.yml'
    data = YAML::load_file(file)
    data.merge(User.last.id => [])
    File.open(file, 'w') {|f| f.write data.to_yaml }
  end

end

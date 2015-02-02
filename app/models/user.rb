class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :name, :on=>:create
  #has_and_belongs_to_many :bills, :join_table => "bills_users" 
  has_many :involved_in_bills
  has_many :bills, :through => :involved_in_bills
  has_many :working_on_tasks
  has_many :tasks, :through => :working_on_tasks
  #has_and_belongs_to_many :tasks, :join_table => "tasks_users"
  belongs_to :flat
  has_many :todos
  has_many :invitations, :class_name => "Invite", :foreign_key => 'recipient_id'
  has_many :sent_invites, :class_name => "Invite", :foreign_key => 'sender_id'
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end

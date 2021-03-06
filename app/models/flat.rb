class Flat < ActiveRecord::Base
  has_many :users
  has_many :invites
  has_many :tasks
  validates_presence_of :name, :on=>:create
  has_one :owner, class_name: "User"
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/flat/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end

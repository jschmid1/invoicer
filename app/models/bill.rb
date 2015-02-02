class Bill < ActiveRecord::Base
  has_many :involved_in_bills
  has_many :users, :through => :involved_in_bills
  #has_and_belongs_to_many :users , :join_table => "bills_users"
  has_one :market
  validates :value, presence: true
  validates :market_id, presence: true
  #accepts_nested_attributes_for :user
end

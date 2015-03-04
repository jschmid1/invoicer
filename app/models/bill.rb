class Bill < ActiveRecord::Base
  has_many :involved_in_bills
  has_many :users, :through => :involved_in_bills
  has_one :market
  validates :value, presence: true
  validates :market_id, presence: true
end

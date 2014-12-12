class Bill < ActiveRecord::Base
  belongs_to :user
  has_one :market
  validates :value, presence: true
  validates :market_id, presence: true
  accepts_nested_attributes_for :user
end

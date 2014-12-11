class InvolvedInBill < ActiveRecord::Base
  has_many :user
  has_many :bill
end

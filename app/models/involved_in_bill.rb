class InvolvedInBill < ActiveRecord::Base
  has_many :user
  has_many :bill

  def self.usernames_by_bill_id(bill_id)
    ids = InvolvedInBill.where(bill_id: bill_id).pluck(:user_id)
    User.where(id: ids).pluck(:name)
  end

end

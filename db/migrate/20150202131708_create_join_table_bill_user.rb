class CreateJoinTableBillUser < ActiveRecord::Migration
  def change
    create_join_table :bills, :users do |t|
       t.index [:bill_id, :user_id]
       t.index [:user_id, :bill_id]
    end
  end
end

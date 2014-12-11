class CreateInvolvedInBills < ActiveRecord::Migration
  def change
    create_table :involved_in_bills do |t|
      t.integer :user_id
      t.integer :bill_id

      t.timestamps
    end
  end
end

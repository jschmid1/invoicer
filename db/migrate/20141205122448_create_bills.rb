class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.float :value
      t.integer :user_id
      t.integer :market_id

      t.timestamps
    end
  end
end

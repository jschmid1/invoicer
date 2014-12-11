class CreateMarkets < ActiveRecord::Migration
  def change
    create_table :markets do |t|
      t.string :name
      t.integer :count
      t.integer :voucher

      t.timestamps
    end
  end
end

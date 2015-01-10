class AddNotesToBills < ActiveRecord::Migration
  def change
    add_column :bills, :note, :string
  end
end

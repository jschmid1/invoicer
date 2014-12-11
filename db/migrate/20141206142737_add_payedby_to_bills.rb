class AddPayedbyToBills < ActiveRecord::Migration
  def change
    add_column :bills, :payedby, :integer
  end
end

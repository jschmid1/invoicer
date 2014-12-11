class AddFlatIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :flat_id, :integer
  end
end

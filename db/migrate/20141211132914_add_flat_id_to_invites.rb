class AddFlatIdToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :flat_id, :integer
  end
end

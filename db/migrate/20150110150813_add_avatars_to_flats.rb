class AddAvatarsToFlats < ActiveRecord::Migration
  def self.up
    change_table :flats do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :flats, :avatar
  end
end

class CreateFlats < ActiveRecord::Migration
  def change
    create_table :flats do |t|
      t.string :name
      t.integer :owner

      t.timestamps
    end
  end
end

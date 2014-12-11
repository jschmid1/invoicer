class CreateFlats < ActiveRecord::Migration
  def change
    create_table :flats do |t|
      t.string :name

      t.timestamps
    end
  end
end

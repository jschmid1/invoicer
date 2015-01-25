class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.integer :credit
      t.string :interval

      t.timestamps
    end
  end
end

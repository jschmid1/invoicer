class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :task
      t.boolean :done, default: false
      t.integer :user_id

      t.timestamps
    end
  end
end

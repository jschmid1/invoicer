class CreateWorkingOnTasks < ActiveRecord::Migration
  def change
    create_table :working_on_tasks do |t|
      t.integer :user_id
      t.integer :task_id
      t.datetime :start_time, :default => Time.now
      t.datetime :end_time, :default => Time.now+2.weeks
      t.boolean :done, :default => false
      t.timestamps
    end
  end
end

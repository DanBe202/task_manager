class AddNotesToTasks < ActiveRecord::Migration[8.1]
  def change
    add_column :tasks, :notes, :text
  end
end

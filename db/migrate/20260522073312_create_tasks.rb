class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :category
      t.integer :priority, default: 0
      t.date :due_date
      t.integer :estimated_hours
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end

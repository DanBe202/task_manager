class CreateAttachments < ActiveRecord::Migration[8.1]
  def change
    create_table :attachments do |t|
      t.string :filename
      t.string :url
      t.integer :task_id

      t.timestamps
    end
  end
end

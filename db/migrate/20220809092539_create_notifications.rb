class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.integer :recipient_id
      t.string :action
      t.integer :actor_id
      t.datetime :read_at
      t.integer :notifiable_id
      t.string :notifiable_type

      t.timestamps
    end
  end
end

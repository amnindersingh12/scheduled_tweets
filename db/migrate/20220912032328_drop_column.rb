class DropColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :tweets, :publish_at
  end
end

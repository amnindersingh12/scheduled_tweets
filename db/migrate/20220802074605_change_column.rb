class ChangeColumn < ActiveRecord::Migration[7.0]
  def change
  change_column :tweets, :tweet_id, :integer
  end
end

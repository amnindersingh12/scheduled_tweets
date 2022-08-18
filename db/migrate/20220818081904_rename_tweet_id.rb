class RenameTweetId < ActiveRecord::Migration[7.0]
  def change
    rename_column :tweets, :tweet_id, :parent_tweet_id
  end
end

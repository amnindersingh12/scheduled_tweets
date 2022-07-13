class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest
      t.timestamps
    end

  #   create_table :tweets do |t|
  #     t.belongs_to :user, null: false, foreign_key: true
  #     t.text :body
  #     t.datetime :publish_at
  #     t.string :tweet_id
  #     t.timestamps
  #   end
  end
end

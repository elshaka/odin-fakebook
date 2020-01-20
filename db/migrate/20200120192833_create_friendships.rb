class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.references :user
      t.integer :friend_id
      t.boolean :confirmed, default: false
    end
  end
end

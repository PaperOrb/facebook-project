class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :friend, index: true, foreign_key: { to_table: :users }
      t.boolean :confirmed

      t.timestamps
    end
  end
end

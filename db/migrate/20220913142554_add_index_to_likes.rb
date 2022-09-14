class AddIndexToLikes < ActiveRecord::Migration[6.1]
  def change
    add_index :likes, [:music_id, :user_id], unique: true
  end
end
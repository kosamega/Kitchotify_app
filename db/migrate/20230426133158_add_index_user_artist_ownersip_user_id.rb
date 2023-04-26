class AddIndexUserArtistOwnersipUserId < ActiveRecord::Migration[7.0]
  def change
    add_index :user_artist_ownerships, :user_id
    add_index :user_artist_ownerships, :artist_id
    add_index :user_artist_ownerships, [:user_id, :artist_id], unique: true
  end
end

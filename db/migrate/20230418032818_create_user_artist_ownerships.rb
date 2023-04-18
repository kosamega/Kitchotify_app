class CreateUserArtistOwnerships < ActiveRecord::Migration[7.0]
  def change
    create_table :user_artist_ownerships do |t|
      t.integer :user_id
      t.integer :artist_id

      t.timestamps
    end
  end
end

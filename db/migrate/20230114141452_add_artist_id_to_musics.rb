class AddArtistIdToMusics < ActiveRecord::Migration[7.0]
  def change
    add_column :musics, :artist_id, :integer
  end
end

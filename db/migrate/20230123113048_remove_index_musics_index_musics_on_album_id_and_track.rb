class RemoveIndexMusicsIndexMusicsOnAlbumIdAndTrack < ActiveRecord::Migration[7.0]
  def change
    remove_index :musics, [:album_id, :track]
  end
end

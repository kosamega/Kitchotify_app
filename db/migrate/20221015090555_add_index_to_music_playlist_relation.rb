class AddIndexToMusicPlaylistRelation < ActiveRecord::Migration[6.1]
  def change
    add_index :music_playlist_relations, [:playlist_id, :tr_num], unique: true
  end
end

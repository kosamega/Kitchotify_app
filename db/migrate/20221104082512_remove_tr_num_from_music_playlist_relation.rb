class RemoveTrNumFromMusicPlaylistRelation < ActiveRecord::Migration[6.1]
  def change
    remove_column :music_playlist_relations, :tr_num, :integer
    add_column :music_playlist_relations, :position, :integer
  end
end

class AddColmunToMusicPlaylistRelation < ActiveRecord::Migration[6.1]
  def change
    add_column :music_playlist_relations, :tr_num, :integer
  end
end

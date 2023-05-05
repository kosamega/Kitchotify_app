class RenameThreePointMusics < ActiveRecord::Migration[7.0]
  def change
    rename_column :daikichi_votes, :three_point_musics, :three_point_music_ids
    rename_column :daikichi_votes, :two_point_musics, :two_point_music_ids
    rename_column :daikichi_votes, :one_point_musics, :one_point_music_ids
  end
end

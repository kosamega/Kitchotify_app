class RenameAlbumsForVoting < ActiveRecord::Migration[7.0]
  def change
    rename_column :daikichi_forms, :albums_for_voting, :music_ids_for_voting
  end
end

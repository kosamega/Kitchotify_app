class RenamePublicColumnToPlaylists < ActiveRecord::Migration[7.0]
  def change
    rename_column :playlists, :public, :open_range
  end
end

class AddPublicToPlaylist < ActiveRecord::Migration[7.0]
  def change
    add_column :playlists, :public, :boolean, default: false
  end
end

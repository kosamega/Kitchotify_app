class AddPublicToPlaylists < ActiveRecord::Migration[6.1]
  def change
    add_column :playlists, :public, :integer
    add_column :playlists, :comment, :text
  end
end

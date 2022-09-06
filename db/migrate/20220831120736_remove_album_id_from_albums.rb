class RemoveAlbumIdFromAlbums < ActiveRecord::Migration[6.1]
  def change
    remove_column :albums, :album_id, :integer
  end
end

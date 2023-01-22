class AddAlbumIdToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :album_id, :integer
  end
end

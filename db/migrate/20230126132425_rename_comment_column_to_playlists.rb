class RenameCommentColumnToPlaylists < ActiveRecord::Migration[7.0]
  def change
    rename_column :playlists, :comment, :description
  end
end

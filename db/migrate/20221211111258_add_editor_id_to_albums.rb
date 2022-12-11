class AddEditorIdToAlbums < ActiveRecord::Migration[6.1]
  def change
    add_column :albums, :editor_id, :integer
  end
end

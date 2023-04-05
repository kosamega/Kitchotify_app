class AddDesignerColumnToAlbum < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :designer_id, :integer
  end
end

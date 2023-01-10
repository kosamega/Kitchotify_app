class RemoveImgPathFromAlbums < ActiveRecord::Migration[7.0]
  def change
    remove_column :albums, :img_path, :string
  end
end

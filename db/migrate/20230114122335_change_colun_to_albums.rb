class ChangeColunToAlbums < ActiveRecord::Migration[7.0]
  def change
    change_column_null :albums, :name, false
  end
end

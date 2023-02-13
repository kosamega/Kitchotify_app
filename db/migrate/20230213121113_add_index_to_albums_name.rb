class AddIndexToAlbumsName < ActiveRecord::Migration[7.0]
  def change
    add_index :albums, :name, unique: true
  end
end

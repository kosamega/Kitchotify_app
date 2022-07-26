class CreateAlbums < ActiveRecord::Migration[6.1]
  def change
    create_table :albums do |t|
      t.integer :album_id
      t.string :name
      t.string :img_path

      t.timestamps
    end
  end
end

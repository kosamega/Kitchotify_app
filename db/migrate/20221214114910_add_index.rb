class AddIndex < ActiveRecord::Migration[7.0]
  def change
    add_index :musics, [:album_id, :track], unique: true
  end
end

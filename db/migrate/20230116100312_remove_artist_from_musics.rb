class RemoveArtistFromMusics < ActiveRecord::Migration[7.0]
  def change
    remove_column :musics, :artist, :string
  end
end

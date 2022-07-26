class CreateMusics < ActiveRecord::Migration[6.1]
  def change
    create_table :musics do |t|
      t.string :name
      t.string :artist
      t.integer :album_id
      t.integer :track
      t.string :audio_path

      t.timestamps
    end
  end
end

class AddDaikichiIdToMusics < ActiveRecord::Migration[7.0]
  def change
    add_column :musics, :daikichi_id, :integer
    add_column :musics, :d_track, :integer
  end
end

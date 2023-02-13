class AddIndexToMusics < ActiveRecord::Migration[7.0]
  def change
    add_index :musics, :name
  end
end

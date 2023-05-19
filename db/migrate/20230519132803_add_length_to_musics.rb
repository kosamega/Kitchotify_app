class AddLengthToMusics < ActiveRecord::Migration[7.0]
  def change
    add_column :musics, :length, :integer
  end
end

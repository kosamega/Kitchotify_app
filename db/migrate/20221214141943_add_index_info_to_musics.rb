class AddIndexInfoToMusics < ActiveRecord::Migration[7.0]
  def change
    add_column :musics, :index_info, :string
  end
end

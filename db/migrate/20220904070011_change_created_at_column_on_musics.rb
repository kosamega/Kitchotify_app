class ChangeCreatedAtColumnOnMusics < ActiveRecord::Migration[6.1]
  def change
    change_column_null :musics, :created_at, true
    change_column_null :musics, :updated_at, true
  end
end

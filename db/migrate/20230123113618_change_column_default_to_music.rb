class ChangeColumnDefaultToMusic < ActiveRecord::Migration[7.0]
  def change
    change_column_default :musics, :track, from: nil, to: "0"
  end
end

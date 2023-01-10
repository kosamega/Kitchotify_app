class RemoveOpenRangeFromPlaylists < ActiveRecord::Migration[7.0]
  def change
    remove_column :playlists, :open_range, :integer
  end
end

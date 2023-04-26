class RemoveUserIdFromArtists < ActiveRecord::Migration[7.0]
  def change
    remove_column :artists, :user_id, :integer
  end
end

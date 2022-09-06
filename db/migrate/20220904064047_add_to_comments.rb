class AddToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :music_id, :integer
  end
end

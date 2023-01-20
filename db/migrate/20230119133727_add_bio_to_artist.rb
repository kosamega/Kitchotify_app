class AddBioToArtist < ActiveRecord::Migration[7.0]
  def change
    add_column :artists, :bio, :string
  end
end

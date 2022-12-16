class AddReleasedToAlbums < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :released, :boolean, default: false
    add_column :albums, :kiki_taikai_yr_mo, :date
  end
end

class RenameKikiTaikaiYrMonColumnToAlbums < ActiveRecord::Migration[7.0]
  def change
    rename_column :albums, :kiki_taikai_yr_mo, :kiki_taikai_date
  end
end

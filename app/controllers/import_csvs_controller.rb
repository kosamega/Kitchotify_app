require 'csv'

class ImportCsvsController < ApplicationController
  before_action :logged_in_user

  def show; end

  def new; end

  def create
    rows = CSV.read(params[:csv], encoding: 'BOM|UTF-8', headers: true)
    rows.each do |row|
      album = Album.find_or_create_by!(name: row['album_name'], kiki_taikai_date: row['kiki_taikai_date'])
      artist = Artist.find_or_create_by!(name: row['artist_name'])
      album.musics.create!(
        name: row['music_name'],
        artist_id: artist.id,
        track: row['track']
      )
    end
    flash['success'] = "#{rows.length}件インポートしました"
    redirect_to new_import_csvs_path
  end
end

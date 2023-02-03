class StaticPagesController < ApplicationController
  before_action :logged_in_user

  def home
    @albums_released = Album.where(released: true).includes(jacket_attachment: [blob: :variant_records])
    @comments = Comment.limit(10).includes([music: :artist], :user, [album: [jacket_attachment: [blob: :variant_records]]])
    @playlists = Playlist.where(public: true).includes(:user)[0..9]
  end
end

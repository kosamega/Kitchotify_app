class StaticPagesController < ApplicationController
  before_action :logged_in_user

  def home
    @albums_released = Album.where(released: true).with_attached_jacket
    @comments = Comment.limit(10).includes([music: :album], :user)
    @playlists = Playlist.where(public: true).includes(:user)[0..9]
  end
end

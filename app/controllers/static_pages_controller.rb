class StaticPagesController < ApplicationController
  before_action :logged_in_user

  def home
    @albums_released = Album.where(released: true)
    @comments = Comment.limit(10)
    @playlists = Playlist.where(public: true)[0..9]
  end
end

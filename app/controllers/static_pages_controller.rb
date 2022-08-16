class StaticPagesController < ApplicationController
  before_action :logged_in_user

  def home
    @albums = Album.all
    @comments = Comment.all[0..9]
    @playlists = Playlist.where(public: 1)[0..9]
  end
end
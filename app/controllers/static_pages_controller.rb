class StaticPagesController < ApplicationController
  before_action :logged_in_user

  def home
    @albums = Album.all
    @comments = Comment.all[1..10]
  end
end
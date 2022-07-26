class StaticPagesController < ApplicationController
  def home
    @albums = Album.all
  end
end

class PositionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :correct_user

  def update
    return if params[:drag] == params[:drop]

    MusicPlaylistRelation.find_by(playlist_id: params[:playlist_id],
                                  position: params[:drag]).insert_at(params[:drop].to_i)
  end

  private

  def correct_user
    redirect_to '/' unless current_user == Playlist.find(params[:playlist_id]).user
  end
end

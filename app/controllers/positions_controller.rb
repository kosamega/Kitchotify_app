class PositionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def update
    return if params[:drag] == params[:drop]

    MusicPlaylistRelation.find_by(playlist_id: params[:playlist_id],
                                  position: params[:drag]).insert_at(params[:drop].to_i)
  end
end

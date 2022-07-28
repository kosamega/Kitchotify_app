class MusicPlaylistRelationsController < ApplicationController
    before_action :logged_in_user
    def create
        relation = MusicPlaylistRelation.new(music_id: params[:music_id], playlist_id: params[:playlist_id])
        relation.save
        redirect_back_or "/"
    end

    def destroy
        relation = MusicPlaylistRelation.find_by(music_id: params[:music_id], playlist_id: params[:playlist_id])
        relation.destroy
        redirect_back_or "/"
    end
end

class MusicsController < ApplicationController
    before_action :logged_in_user
    def show
        @music = Music.find_by(id: params[:id])
        @comments = @music.comments
    end
end

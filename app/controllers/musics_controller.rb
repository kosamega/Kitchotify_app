class MusicsController < ApplicationController
    def show
        @music = Music.find_by(id: params[:id])
    end
end

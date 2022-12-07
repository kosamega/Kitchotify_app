class MusicsController < ApplicationController
    before_action :logged_in_user
    
    def show
        if @music = Music.find_by(id: params[:id])
            @playlists = current_user.playlists
            @artistsmusics = Music.where(artist: @music.artist)
            @comments = @music.comments
            @infos = []
            require 'aws-sdk-s3'
            s3 = Aws::S3::Client.new
            signer = Aws::S3::Presigner.new(client: s3)
            url = signer.presigned_url(:get_object, 
                                        bucket: 'kitchotifyappstrage',
                                        key: "audio/#{@music.album.id}/#{@music.audio_path}",
                                        expires_in: 7200)
            @infos.push({url: url, name: @music.name, artist: @music.artist})
            gon.infos_j = @infos
            @music_show = true
        else
            render "shared/not_found"
        end
    end
end

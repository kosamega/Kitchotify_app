class MusicsController < ApplicationController
    before_action :logged_in_user
    
    def show
        if @music = Music.find_by(id: params[:id])
            @playlists = current_user.playlists
            @artistsmusics = Music.where(artist: @music.artist)
            @comments = @music.comments
            require 'aws-sdk-s3'
            s3 = Aws::S3::Client.new
            signer = Aws::S3::Presigner.new(client: s3)
            @url = signer.presigned_url(:get_object, 
                                        bucket: 'kitchotifyappstrage',
                                        key: "audio/#{@music.album.id}/#{@music.audio_path}",
                                        expires_in: 1200)
        else
            render "shared/not_found"
        end
    end
end

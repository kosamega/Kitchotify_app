class AlbumsController < ApplicationController
    before_action :logged_in_user
    def show
        if @album = Album.find_by(id: params[:id])
            @musics = @album.musics
            @playlists = current_user.playlists
            @infos = []
            require 'aws-sdk-s3'
            s3 = Aws::S3::Client.new
            signer = Aws::S3::Presigner.new(client: s3)
            @musics.each do |music|
              url = signer.presigned_url(:get_object, 
                                          bucket: 'kitchotifyappstrage',
                                          key: "audio/#{music.album.id}/#{music.audio_path}",
                                          expires_in: 7200)
              @infos.push({url: url, name: music.name, artist: music.artist})
            end
            @infos_j = @infos.to_json.html_safe
        else
            render "shared/not_found"
        end
    end
end

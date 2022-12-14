class AlbumsController < ApplicationController
    before_action :logged_in_user
    before_action :admin_user, only: %i[new create edit update destroy]
    def new
    end

    def create
        @album = Album.create(album_params)
        redirect_to @album
    end

    def edit
        @album = Album.find_by(id: params[:id])
    end

    def update
        @album = Album.find_by(id: params[:id])
        @album.update(album_params)
        @album.update(editor_id: current_user.id)
        redirect_to @album
    end

    def destroy
        Album.find_by(id: params[:id]).destroy
        redirect_to "/"
    end

    def show
        if @album = Album.find_by(id: params[:id])
            @musics = @album.musics
            @playlists = current_user.playlists
            @at_album_show = true
            @infos = []
            require 'aws-sdk-s3'
            s3 = Aws::S3::Client.new
            signer = Aws::S3::Presigner.new(client: s3)
            @musics.each do |music|
              if music.audio.attached?
                url = music.audio.url
              else
                url = signer.presigned_url(:get_object, 
                                            bucket: 'kitchotifyappstrage',
                                            key: "audio/#{music.album.id}/#{music.audio_path}",
                                            expires_in: 7200)
              end
              @infos.push({url: url, name: music.name, artist: music.artist})
            end
            gon.infos_j = @infos
        else
            render "shared/not_found"
        end
    end

    private 
        def album_params
            params.require(:album).permit(:name, :jacket)
        end
end

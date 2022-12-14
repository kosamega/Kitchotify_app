class MusicsController < ApplicationController
    before_action :logged_in_user
    before_action :set_album

    def create
        @music = @album.musics.build(music_params)
        if @music.save
            @message = "曲を追加しました"
            @number = params[:music][:track].to_i - 1
            @playlists = current_user.playlists
            @at_album_show = params[:at_album_show]
            @save = true
        else
            @message = @music.errors.full_messages
            @save = false
        end
        respond_to do |format|
            format.html {redirect_back_or "/"}
            format.js
        end
    end

    def edit
        @music = Music.find_by(id: params[:id])
    end

    def update
        Music.find_by(id: params[:id]).update(music_params)
        @message = "更新しました"
        respond_to do |format|
            format.html {redirect_back_or "/"}
            format.js
        end
    end

    def destroy
        @album.musics.find_by(id: params[:id]).destroy
        redirect_to album_path(@album)
    end

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
                                        key: "audio/#{@music.album.id}/#{@music&.audio_path}",
                                        expires_in: 7200)
            @infos.push({url: url, name: @music.name, artist: @music.artist})
            gon.infos_j = @infos
            @music_show = true
        else
            render "shared/not_found"
        end
    end

    private
        def set_album
            @album = Album.find_by(id: params[:album_id])
        end

        def music_params
            params.require(:music).permit(:name, :artist, :track, :audio)
        end

end

class SearchsController < ApplicationController
    before_action :logged_in_user
    def index
        @playlists = current_user.playlists
        @params = params[:search][:content]
        @result_musics = Music.where("name LIKE ?", "%#{@params}%").or(Music.where("artist LIKE?", "%#{@params}%"))
        @result_users = User.where("name LIKE ?", "%#{@params}%")
        @result_playlists = Playlist.where("name LIKE ?", "%#{@params}%")
        @urls = []
        @music_names = []
        @music_artists = []
        require 'aws-sdk-s3'
        s3 = Aws::S3::Client.new
        signer = Aws::S3::Presigner.new(client: s3)
        @result_musics.each do |music|
          url = signer.presigned_url(:get_object, 
                                      bucket: 'kitchotifyappstrage',
                                      key: "audio/#{music.album.id}/#{music.audio_path}",
                                      expires_in: 7200)
          @urls.push(url)
          @music_names.push(music.name)
          @music_artists.push(music.artist)
        end
        @urls_j = @urls.to_json.html_safe
        @music_names_j = @music_names.to_json.html_safe
        @music_artists_j = @music_artists.to_json.html_safe
    end
end

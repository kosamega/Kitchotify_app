module MusicsHelper
  def set_infos(musics)
    require 'aws-sdk-s3'
    s3 = Aws::S3::Client.new
    signer = Aws::S3::Presigner.new(client: s3)
    musics.each do |music|
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
  end
end

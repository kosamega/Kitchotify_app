module MusicsHelper
  include Rails.application.routes.url_helpers

  def set_infos(musics)
    musics.map.with_index do |music, index|
      { id: index, url: music.audio.url, name: music.name, artist: music.artist.name, index_info: music.index_info }
    end
  end

  def get_music_length(music)
    return unless music.audio.attached?

    s3 = Aws::S3::Client.new(region: ENV.fetch('AWS_REGION', nil), access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID', nil),
                             secret_access_key: ENV.fetch('AWS_SECRET_KEY', nil))
    bucket_name = ENV.fetch('AWS_BUCKET', nil)
    object = s3.get_object(bucket: bucket_name, key: music.audio.key)

    # 一時ファイルに音楽ファイルを保存
    temp_file = Tempfile.new
    temp_file.binmode
    temp_file.write(object.body.read)
    temp_file.close

    AudioInfo.open(temp_file.path, 'mp3') do |info|
      length = info.length
    end
  # 例外が発生したとしても一時ファイルを消す
  ensure
    temp_file&.unlink
  end
end

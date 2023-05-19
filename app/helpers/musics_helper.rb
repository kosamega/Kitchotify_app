module MusicsHelper
  include Rails.application.routes.url_helpers

  def set_infos(musics)
    musics.map.with_index do |music, index|
      { id: index, url: music.audio.url, name: music.name, artist: music.artist.name, index_info: music.index_info }
    end
  end

  def get_music_length(music)
    return unless music.audio.attached?

    s3 = Aws::S3::Client.new(region: ENV['AWS_REGION'], access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_KEY'])
    bucket_name = ENV['AWS_BUCKET']
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
    temp_file.unlink if temp_file
  end
end

class IntroQuizzesController < ApplicationController
  before_action :logged_in_user

  def show
    @playlists = current_user.playlists
    quiz = IntroQuiz.find_by(id: params[:id])
    @q_num = quiz.q_num
    if quiz.range = "full"
      @ids = (1..Music.all.length).to_a.sample(@q_num)
      @musics_all = Music.all
    end
    @infos = []
    @musics = []
    require 'aws-sdk-s3'
    s3 = Aws::S3::Client.new
    signer = Aws::S3::Presigner.new(client: s3)
    @ids.each do |id|
      music = Music.find_by(id: id)
      url = signer.presigned_url(:get_object, 
                                  bucket: 'kitchotifyappstrage',
                                  key: "audio/#{music.album.id}/#{music.audio_path}",
                                  expires_in: 7200)
      @infos.push({url: url, name: music.name, artist: music.artist})
      @musics.push(music)
    end
    gon.infos_j = @infos
    gon.ids = @ids
    gon.q_num = @q_num
    gon.q_id = quiz.id
    @intro_quiz = true
  end

  def index
    @intro_quizzes = IntroQuiz.all
  end
end

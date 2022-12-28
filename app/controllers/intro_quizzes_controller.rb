class IntroQuizzesController < ApplicationController
  before_action :logged_in_user
  include MusicsHelper

  def index
    @intro_quizzes = IntroQuiz.all
  end

  def show
    @playlists = current_user.playlists
    quiz = IntroQuiz.find_by(id: params[:id])
    @q_num = quiz.q_num
    if (quiz.range = 'full')
      @ids = (1..Music.all.length).to_a.sample(@q_num)
      @musics_all = Music.all
    end
    @infos = []
    @musics = @ids.map { |id| Music.find_by(id:) }
    set_infos(@musics)
    gon.infos_j = @infos
    gon.ids = @ids
    gon.q_num = @q_num
    gon.q_id = quiz.id
    @intro_quiz = true
  end
end

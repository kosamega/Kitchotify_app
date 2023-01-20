class IntroQuizzesController < ApplicationController
  before_action :logged_in_user
  before_action :set_current_user_playlists, only: %i[show]

  include MusicsHelper

  def index
    @intro_quizzes = IntroQuiz.all
  end

  def show
    quiz = IntroQuiz.find_by(id: params[:id])
    @q_num = quiz.q_num
    if (quiz.range = 'full')
      @musics_all = Music.all
      @ids = @musics_all.map(&:id).sample(@q_num)
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

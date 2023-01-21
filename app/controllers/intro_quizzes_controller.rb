class IntroQuizzesController < ApplicationController
  before_action :logged_in_user
  before_action :set_current_user_playlists, only: %i[show]
  before_action :set_intro_quiz, only: %i[show]

  include MusicsHelper

  def index
    @intro_quizzes = IntroQuiz.includes(quiz_results: :user)
  end

  def show
    @q_num = @quiz.q_num
    if (@quiz.range = 'full')
      @musics_all = Music.includes(:artist)
      @ids = @musics_all.map(&:id).sample(@q_num)
    end
    @musics = @ids.map{ |id| Music.find_by(id:) }
    @infos = set_infos(@musics)
    gon.infos_j = @infos
    gon.ids = @ids
    gon.q_num = @q_num
    gon.q_id = @quiz.id
    @intro_quiz = true
  end

  def set_intro_quiz
    @quiz = IntroQuiz.find(params[:id])
  end
end

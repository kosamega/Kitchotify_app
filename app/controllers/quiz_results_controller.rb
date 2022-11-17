class QuizResultsController < ApplicationController
  def create
    @result = QuizResult.new(user_id: current_user.id, time: params[:time], intro_quiz_id: params[:intro_quiz_id])
    @result.save!
  end

  def index
  end

  def show
  end
end

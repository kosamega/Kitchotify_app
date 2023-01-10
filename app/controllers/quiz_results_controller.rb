class QuizResultsController < ApplicationController
  before_action :logged_in_user

  def index; end

  def show; end

  def create
    current_user.quiz_results.create!(time: params[:time], intro_quiz_id: params[:intro_quiz_id])
  end
end

class QuizResultsController < ApplicationController
  before_action :logged_in_user

  def index; end

  def show; end

  def create
    @result = QuizResult.new(user_id: current_user.id, time: params[:time], intro_quiz_id: params[:intro_quiz_id])
    @result.save!
  end
end

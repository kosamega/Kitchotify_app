require 'test_helper'

class IntroQuizzesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:admin_user)
    @intro_quiz = intro_quizzes(:intro_quiz1)
  end

  test 'ログインすればshowにアクセスできて、しないとできない' do
    get intro_quiz_path(@intro_quiz)
    assert_redirected_to new_sessions_path
    log_in_as(@admin_user)
    get intro_quiz_path(@intro_quiz)
    assert_response :success
  end

  test 'ログインすればindexにアクセスできて、しないとできない' do
    get intro_quizzes_path
    assert_redirected_to new_sessions_path
    log_in_as(@admin_user)
    get intro_quizzes_path
    assert_response :success
  end
end

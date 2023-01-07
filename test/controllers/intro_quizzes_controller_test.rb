require 'test_helper'

class IntroQuizzesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:kosamega)
    @intro_quiz = intro_quizzes(:one)
  end 

  test "ログインすればshowにアクセスできて、しないとできない" do
    get intro_quiz_path(@intro_quiz)
    assert_redirected_to new_sessions_path
    log_in_as(@user)
    get intro_quiz_path(@intro_quiz)
    assert_response :success
  end

  test "ログインすればindexにアクセスできて、しないとできない" do
    get intro_quizzes_path
    assert_redirected_to new_sessions_path
    log_in_as(@user)
    get intro_quizzes_path
    assert_response :success
  end
end

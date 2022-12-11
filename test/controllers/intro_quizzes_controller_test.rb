require "test_helper"

class IntroQuizzesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @intro_quiz = intro_quiz(:one)
  end 

  test "should get show" do
    get intro_quiz_path(@intro_quiz)
    assert_response :success
  end

  test "should get index" do
    get intro_quizzes_path
    assert_response :success
  end
end

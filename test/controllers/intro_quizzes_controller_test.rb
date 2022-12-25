require 'test_helper'

class IntroQuizzesControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get intro_quizzes_show_url
    assert_response :success
  end

  test 'should get index' do
    get intro_quizzes_index_url
    assert_response :success
  end
end

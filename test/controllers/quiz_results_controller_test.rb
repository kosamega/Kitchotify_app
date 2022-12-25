require 'test_helper'

class QuizResultsControllerTest < ActionDispatch::IntegrationTest
  test 'should get create' do
    get quiz_results_create_url
    assert_response :success
  end

  test 'should get index' do
    get quiz_results_index_url
    assert_response :success
  end
end

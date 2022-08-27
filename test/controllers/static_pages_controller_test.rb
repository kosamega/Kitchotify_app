require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest   
  test "ホーム描写" do
    get "/"
    assert_response :success
  end
end

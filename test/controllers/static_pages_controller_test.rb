require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user1)
  end

  test 'ホーム描写' do
    log_in_as(@user)
    get '/'
    assert_response :success
    assert_select 'title', 'Kitchotify - Home'
  end
end

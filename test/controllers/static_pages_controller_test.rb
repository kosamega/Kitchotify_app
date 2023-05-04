require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:admin_user)
  end

  test 'ホーム描写' do
    log_in_as(@admin_user)
    get root_path
    assert_response :success
    assert_select 'title', 'Kitchotify - Home'
  end
end

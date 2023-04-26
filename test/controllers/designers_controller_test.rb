require 'test_helper'

class DesignersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @designer = designers(:designer1)
    @user1 = users(:user1)
    log_in_as(@user1)
  end

  test 'should get index' do
    get designers_path
    assert_response :success
  end

  test 'should get new' do
    get new_designer_url
    assert_response :success
  end

  test 'should create designer' do
    assert_difference('Designer.count') do
      post designers_url, params: { designer: { name: 'hoge', bio: 'bio' } }
    end
  end

  test 'should show designer' do
    get designer_path(@designer)
    assert_response :success
  end

  test 'should get edit' do
    get edit_designer_url(@designer)
    assert_response :success
  end

  test 'should update designer' do
    patch designer_url(@designer), params: { designer: { name: 'update', bio: 'bio' } }
    assert_redirected_to designer_url(@designer)
  end

  test 'should destroy designer' do
    assert_difference('Designer.count', -1) do
      delete designer_url(@designer)
    end

    assert_redirected_to designers_url
  end
end

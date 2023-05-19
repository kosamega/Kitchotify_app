require 'test_helper'

class DaikichisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @daikichi = daikichis(:daikichi1)
    @admin_user = users(:admin_user)
  end

  test 'should get new' do
    log_in_as(@admin_user)
    get new_daikichi_url
    assert_response :success
  end

  test 'should create daikichi' do
    log_in_as(@admin_user)
    assert_difference('Daikichi.count') do
      post daikichis_url,
           params: { daikichi: { counting_votes_date: '2099-01-01', designer_id: @daikichi.designer_id,
                                 name: '新規大吉', released: false } }
    end

    assert_redirected_to daikichi_url(Daikichi.last)
  end

  test 'should show daikichi' do
    log_in_as(@admin_user)
    get daikichi_url(@daikichi)
    assert_response :success
  end

  test 'should get edit' do
    log_in_as(@admin_user)
    get edit_daikichi_url(@daikichi)
    assert_response :success
  end

  test 'should update daikichi' do
    log_in_as(@admin_user)
    patch daikichi_url(@daikichi),
          params: { daikichi: { counting_votes_date: @daikichi.counting_votes_date, designer_id: @daikichi.designer_id,
                                name: @daikichi.name, released: @daikichi.released } }
    assert_redirected_to daikichi_url(@daikichi)
  end

  test 'should destroy daikichi' do
    log_in_as(@admin_user)
    assert_difference('Daikichi.count', -1) do
      delete daikichi_url(@daikichi)
    end

    assert_redirected_to albums_path
  end
end

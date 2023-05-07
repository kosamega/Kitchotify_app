require 'test_helper'

class DaikichisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @daikichi = daikichis(:one)
  end

  test 'should get new' do
    get new_daikichi_url
    assert_response :success
  end

  test 'should create daikichi' do
    assert_difference('Daikichi.count') do
      post daikichis_url,
           params: { daikichi: { counting_votes_date: @daikichi.counting_votes_date, designer_id: @daikichi.designer_id,
                                 name: @daikichi.name, released: @daikichi.released } }
    end

    assert_redirected_to daikichi_url(Daikichi.last)
  end

  test 'should show daikichi' do
    get daikichi_url(@daikichi)
    assert_response :success
  end

  test 'should get edit' do
    get edit_daikichi_url(@daikichi)
    assert_response :success
  end

  test 'should update daikichi' do
    patch daikichi_url(@daikichi),
          params: { daikichi: { counting_votes_date: @daikichi.counting_votes_date, designer_id: @daikichi.designer_id,
                                name: @daikichi.name, released: @daikichi.released } }
    assert_redirected_to daikichi_url(@daikichi)
  end

  test 'should destroy daikichi' do
    assert_difference('Daikichi.count', -1) do
      delete daikichi_url(@daikichi)
    end

    assert_redirected_to daikichis_url
  end
end

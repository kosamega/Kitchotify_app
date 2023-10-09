require 'test_helper'

class DaikichisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @daikichi_form = daikichi_forms(:daikichi100)
    @admin_user = users(:admin_user)
  end

  test 'should get new' do
    log_in_as(@admin_user)
    get new_daikichi_form_daikichi_result_daikichi_path(@daikichi_form)
    assert_response :success
  end

  test 'should create daikichi' do
    log_in_as(@admin_user)
    assert_difference('Album.count') do
      post daikichi_form_daikichi_result_daikichis_path(@daikichi_form),
           params: { music_ids: [musics(:music1).id, musics(:music2).id] }
    end

    assert_redirected_to album_path(Album.find_by(name: @daikichi_form.name.delete('投票')))
  end
end

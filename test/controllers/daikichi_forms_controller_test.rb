require 'test_helper'

class DaikichiFormsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @daikichi_form = DaikichiForm.create(name: 'touhyou', three_point: 1, two_point: 1, one_point: 2, form_closed: false,
      music_ids_for_voting: [musics(:music1).id, musics(:music2).id, musics(:music3).id, musics(:music4).id], accept_until: '2099-01-01T00:00:00')
    @admin_user = users(:admin_user)
    @not_admin_user = users(:not_admin_user)
  end

  test 'ログインしないとindexにアクセスできない' do
    get daikichi_forms_url
    assert_not flash.empty?
    assert_redirected_to new_sessions_path
    log_in_as(@admin_user)
    get daikichi_forms_url
    assert_response :success
  end

  test 'adminのみnewにアクセスできる' do
    log_in_as(@not_admin_user)
    get new_daikichi_form_url
    assert_not flash.empty?
    assert_redirected_to root_path
    delete sessions_path
    log_in_as(@admin_user)
    get new_daikichi_form_url
    assert_response :success
  end

  test 'adminのみformを作成できる' do
    log_in_as(@not_admin_user)
    assert_no_difference 'DaikichiForm.count' do
      post daikichi_forms_url,
      params: { daikichi_form: { one_point: 1, two_point: 2,
                                 three_point: 2, music_ids_for_voting: @daikichi_form.music_ids_for_voting, form_closed: false, name: 'touhyo2', accept_until: '2099-01-01T00:00:00' } }
    end
    delete sessions_path
    log_in_as(@admin_user)
    assert_difference('DaikichiForm.count') do
      post daikichi_forms_url,
      params: { daikichi_form: { one_point: 1, two_point: 2,
                                 three_point: 2, music_ids_for_voting: @daikichi_form.music_ids_for_voting, form_closed: false, name: 'touhyo2', accept_until: '2099-01-01T00:00:00' } }
    end
    assert_redirected_to daikichi_form_url(DaikichiForm.last)
  end

  test 'ログインするとshowにアクセスできる' do
    get daikichi_form_url(@daikichi_form)
    assert_not flash.empty?
    assert_redirected_to new_sessions_path
    log_in_as(@not_admin_user)
    get daikichi_form_url(@daikichi_form)
    assert_response :success
  end

  test 'adminのみeditにアクセスできる' do
    log_in_as(@not_admin_user)
    get edit_daikichi_form_url(@daikichi_form)
    assert_not flash.empty?
    assert_redirected_to root_path
    delete sessions_path
    log_in_as(@admin_user)
    get edit_daikichi_form_url(@daikichi_form)
    assert_response :success
  end

  test 'adminのみformを更新できる' do
    log_in_as(@not_admin_user)
    patch daikichi_form_url(@daikichi_form),
    params: { daikichi_form: { one_point: @daikichi_form.one_point, two_point: @daikichi_form.two_point,
                               three_point: @daikichi_form.three_point, music_ids_for_voting: @daikichi_form.music_ids_for_voting, form_closed: @daikichi_form.form_closed, name: @daikichi_form.name, accept_until: '2099-01-01T00:00:00' } }
    assert_redirected_to root_path

    delete sessions_path
    log_in_as(@admin_user)
    patch daikichi_form_url(@daikichi_form),
          params: { daikichi_form: { one_point: @daikichi_form.one_point, two_point: @daikichi_form.two_point,
                                     three_point: @daikichi_form.three_point, music_ids_for_voting: @daikichi_form.music_ids_for_voting, form_closed: @daikichi_form.form_closed, name: @daikichi_form.name, accept_until: '2099-01-01T00:00:00' } }
    assert_redirected_to daikichi_form_url(@daikichi_form)
  end

  test 'adminのみformを削除できる' do
    log_in_as(@not_admin_user)
    assert_no_difference('DaikichiForm.count') do
      delete daikichi_form_url(@daikichi_form)
    end
    assert_redirected_to root_path

    delete sessions_path
    log_in_as(@admin_user)
    assert_difference('DaikichiForm.count', -1) do
      delete daikichi_form_url(@daikichi_form)
    end

    assert_redirected_to daikichi_forms_url
  end
end

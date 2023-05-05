require 'test_helper'

class DaikichiResultsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:admin_user)
    @not_admin_user = users(:not_admin_user)
    @daikichi_form = DaikichiForm.create(name: 'touhyou', three_point: 1, two_point: 1, one_point: 2, form_closed: false,
                                         music_ids_for_voting: [musics(:music1).id, musics(:music2).id, musics(:music3).id, musics(:music4).id], accept_until: '2099-01-01T00:00:00', result_open: false)
    @daikichi_vote = @daikichi_form.daikichi_votes.build(user_id: users(:admin_user).id, three_point_music_ids: [musics(:music1).id],
                                                         two_point_music_ids: [musics(:music2).id], one_point_music_ids: [musics(:music3).id, musics(:music4).id])
  end

  test '結果が公開されるまでadmin以外showにアクセスできない' do
    log_in_as(@admin_user)
    get daikichi_form_daikichi_result_path(@daikichi_form)
    assert :success
    delete sessions_path
    log_in_as(@not_admin_user)
    get daikichi_form_daikichi_result_path(@daikichi_form)
    assert_redirected_to daikichi_forms_path
    @daikichi_form.update(result_open: true)
    get daikichi_form_daikichi_result_path(@daikichi_form)
    assert :success
  end
end

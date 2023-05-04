require 'test_helper'

class DaikichiVotesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:admin_user)
    @not_admin_user = users(:not_admin_user) 
    @daikichi_form = DaikichiForm.create(name: 'touhyou', three_point: 1, two_point: 1, one_point: 2, closed: false,
      albums_for_voting: [albums(:album1).id, albums(:album2).id], accept_until: '2099-01-01T00:00:00')
    @daikichi_vote = @daikichi_form.daikichi_votes.build(user_id: users(:admin_user).id, three_point_musics: [musics(:music1).id],
    two_point_musics: [musics(:music2).id], one_point_musics: [musics(:music3).id, musics(:music4).id])
    @daikichi_form_closed = DaikichiForm.create(name: 'closed', three_point: 1, two_point: 1, one_point: 2, closed: true,
      albums_for_voting: [albums(:album1).id, albums(:album2).id], accept_until: '2099-01-01T00:00:00')
    @daikichi_vote_for_closed = @daikichi_form_closed.daikichi_votes.build(user_id: users(:admin_user).id, three_point_musics: [musics(:music1).id],
    two_point_musics: [musics(:music2).id], one_point_musics: [musics(:music3).id, musics(:music4).id])
  end

  test 'adminのみindexにアクセスできる' do
    log_in_as(@not_admin_user)
    get daikichi_form_daikichi_votes_path(@daikichi_form)
    assert_redirected_to root_path
    delete sessions_path
    log_in_as(@admin_user)
    get daikichi_form_daikichi_votes_path(@daikichi_form)
    assert_response :success
  end

  test 'ログインしないとnewにアクセスできない' do
    delete sessions_path
    get new_daikichi_form_daikichi_vote_url(@daikichi_form)
    assert_redirected_to new_sessions_path
    log_in_as(@not_admin_user)
    get new_daikichi_form_daikichi_vote_url(@daikichi_form)
    assert_response :success
  end

  test '適切なユーザーのみ投票を作成できる' do
    log_in_as(@not_admin_user)
    assert_no_difference('DaikichiVote.count') do
      post daikichi_form_daikichi_votes_url(@daikichi_form),
           params: { daikichi_vote: { daikichi_form_id: @daikichi_vote.daikichi_form_id,
                                      one_point_musics: @daikichi_vote.one_point_musics, three_point_musics: @daikichi_vote.three_point_musics, two_point_musics: @daikichi_vote.two_point_musics, user_id: @daikichi_vote.user_id } }
    end
    assert_redirected_to daikichi_forms_path

    assert_difference('DaikichiVote.count') do
      post daikichi_form_daikichi_votes_url(@daikichi_form),
           params: { daikichi_vote: { daikichi_form_id: @daikichi_vote.daikichi_form_id,
                                      one_point_musics: @daikichi_vote.one_point_musics, three_point_musics: @daikichi_vote.three_point_musics, two_point_musics: @daikichi_vote.two_point_musics, user_id: @not_admin_user.id } }
    end
    assert_redirected_to daikichi_form_url(@daikichi_form)
  end

  test '適切なユーザーのみshowにアクセスできる' do
    @daikichi_vote.save
    log_in_as(@not_admin_user)
    get daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote)
    assert_redirected_to daikichi_forms_path
    delete sessions_path
    log_in_as(@admin_user)
    get daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote)
    assert_response :success
  end

  test '適切なユーザーのみ投票のeditにアクセスできる' do
    @daikichi_vote.save
    log_in_as(@not_admin_user)
    get edit_daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote)
    assert_redirected_to daikichi_forms_path
    delete sessions_path
    log_in_as(@admin_user)
    get edit_daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote)
    assert_response :success
  end

  test '適切なユーザーのみ投票をupdateできる' do
    @daikichi_vote.save
    log_in_as(@not_admin_user)
    patch daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote),
          params: { daikichi_vote: { daikichi_form_id: @daikichi_vote.daikichi_form_id,
                                     one_point_musics: @daikichi_vote.one_point_musics, three_point_musics: @daikichi_vote.three_point_musics, two_point_musics: @daikichi_vote.two_point_musics, user_id: @daikichi_vote.user_id } }
    assert_redirected_to daikichi_forms_path
    delete sessions_path
    log_in_as(@admin_user)
    patch daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote),
    params: { daikichi_vote: { daikichi_form_id: @daikichi_vote.daikichi_form_id,
                               one_point_musics: @daikichi_vote.one_point_musics, three_point_musics: @daikichi_vote.three_point_musics, two_point_musics: @daikichi_vote.two_point_musics, user_id: @daikichi_vote.user_id } }
    assert_redirected_to daikichi_form_path(@daikichi_form)
  end

  test 'adminのみ投票を削除できる' do
    @daikichi_vote.save
    log_in_as(@not_admin_user)
    assert_no_difference('DaikichiVote.count') do
      delete daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote)
    end
    assert_redirected_to root_path
    delete sessions_path
    log_in_as(@admin_user)
    assert_difference('DaikichiVote.count', -1) do
      delete daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote)
    end
    assert_redirected_to daikichi_form_daikichi_votes_url(@daikichi_form)
  end
  
  test 'admin以外はフォームが閉じているときは投票できない' do
    log_in_as(@not_admin_user)
    assert_no_difference('DaikichiVote.count') do
      post daikichi_form_daikichi_votes_url(@daikichi_form_closed),
           params: { daikichi_vote: { daikichi_form_id: @daikichi_vote_for_closed.daikichi_form_id,
                                      one_point_musics: @daikichi_vote_for_closed.one_point_musics, three_point_musics: @daikichi_vote_for_closed.three_point_musics, two_point_musics: @daikichi_vote_for_closed.two_point_musics, user_id: @not_admin_user.id } }
    end
    assert_redirected_to daikichi_forms_path
    delete sessions_path
    log_in_as(@admin_user)
    assert_difference('DaikichiVote.count') do
      post daikichi_form_daikichi_votes_url(@daikichi_form_closed),
           params: { daikichi_vote: { daikichi_form_id: @daikichi_vote_for_closed.daikichi_form_id,
                                      one_point_musics: @daikichi_vote_for_closed.one_point_musics, three_point_musics: @daikichi_vote_for_closed.three_point_musics, two_point_musics: @daikichi_vote_for_closed.two_point_musics, user_id: @daikichi_vote_for_closed.user_id } }
    end
    assert_redirected_to daikichi_form_url(@daikichi_form_closed)
  end

  test 'すでに投票済みの場合投票を作成できずnewにもアクセスできない' do
    @daikichi_vote.save
    log_in_as(@admin_user)
    get new_daikichi_form_daikichi_vote_path(@daikichi_form)
    assert_redirected_to edit_daikichi_form_daikichi_vote_path(@daikichi_form, @daikichi_vote)
    assert_no_difference('DaikichiVote.count') do
      post daikichi_form_daikichi_votes_url(@daikichi_form),
           params: { daikichi_vote: { daikichi_form_id: @daikichi_vote.daikichi_form_id,
                                      one_point_musics: @daikichi_vote.one_point_musics, three_point_musics: @daikichi_vote.three_point_musics, two_point_musics: @daikichi_vote.two_point_musics, user_id: @daikichi_vote.user_id } }
    end
    assert_redirected_to edit_daikichi_form_daikichi_vote_path(@daikichi_form, @daikichi_vote)
  end
end

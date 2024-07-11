require 'test_helper'

class DaikichiVotesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @producer_user = users(:producer_user)
    @member_user = users(:member_user)
    @daikichi_form = DaikichiForm.create(name: 'touhyou', three_point: 1, two_point: 1, one_point: 2, form_closed: false,
                                         music_ids_for_voting: [musics(:music1).id, musics(:music2).id, musics(:music3).id, musics(:music4).id], accept_until: '2099-01-01T00:00:00')
    @daikichi_vote = @daikichi_form.daikichi_votes.build(user_id: users(:producer_user).id, three_point_music_ids: [musics(:music1).id],
                                                         two_point_music_ids: [musics(:music2).id], one_point_music_ids: [musics(:music3).id, musics(:music4).id])
    @daikichi_form_closed = DaikichiForm.create(name: 'form_closed', three_point: 1, two_point: 1, one_point: 2, form_closed: true,
                                                music_ids_for_voting: [musics(:music1).id, musics(:music2).id, musics(:music3).id, musics(:music4).id], accept_until: '2099-01-01T00:00:00')
    @daikichi_vote_for_closed = @daikichi_form_closed.daikichi_votes.build(user_id: users(:producer_user).id, three_point_music_ids: [musics(:music1).id],
                                                                           two_point_music_ids: [musics(:music2).id], one_point_music_ids: [musics(:music3).id, musics(:music4).id])
  end

  test 'producerのみindexにアクセスできる' do
    log_in_as(@member_user)
    get daikichi_form_daikichi_votes_path(@daikichi_form)
    assert_redirected_to root_path
    delete sessions_path
    log_in_as(@producer_user)
    get daikichi_form_daikichi_votes_path(@daikichi_form)
    assert_response :success
  end

  test 'ログインしないとnewにアクセスできない' do
    delete sessions_path
    get new_daikichi_form_daikichi_vote_url(@daikichi_form)
    assert_redirected_to new_sessions_path
    log_in_as(@member_user)
    get new_daikichi_form_daikichi_vote_url(@daikichi_form)
    assert_response :success
  end

  test '適切なユーザーのみ投票を作成できる' do
    log_in_as(@member_user)
    assert_no_difference('DaikichiVote.count') do
      post daikichi_form_daikichi_votes_url(@daikichi_form),
           params: { daikichi_vote: { daikichi_form_id: @daikichi_vote.daikichi_form_id,
                                      one_point_music_ids: @daikichi_vote.one_point_music_ids, three_point_music_ids: @daikichi_vote.three_point_music_ids, two_point_music_ids: @daikichi_vote.two_point_music_ids, user_id: @daikichi_vote.user_id } }
    end
    assert_redirected_to daikichi_forms_path

    assert_difference('DaikichiVote.count') do
      post daikichi_form_daikichi_votes_url(@daikichi_form),
           params: { daikichi_vote: { daikichi_form_id: @daikichi_vote.daikichi_form_id,
                                      one_point_music_ids: @daikichi_vote.one_point_music_ids, three_point_music_ids: @daikichi_vote.three_point_music_ids, two_point_music_ids: @daikichi_vote.two_point_music_ids, user_id: @member_user.id } }
    end
    assert_redirected_to daikichi_form_daikichi_vote_path(@daikichi_form, DaikichiVote.last)
  end

  test '適切なユーザーのみshowにアクセスできる' do
    @daikichi_vote.save
    log_in_as(@member_user)
    get daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote)
    assert_redirected_to daikichi_forms_path
    delete sessions_path
    log_in_as(@producer_user)
    get daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote)
    assert_response :success
  end

  test '適切なユーザーのみ投票のeditにアクセスできる' do
    @daikichi_vote.save
    log_in_as(@member_user)
    get edit_daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote)
    assert_redirected_to daikichi_forms_path
    delete sessions_path
    log_in_as(@producer_user)
    get edit_daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote)
    assert_response :success
  end

  test '適切なユーザーのみ投票をupdateできる' do
    @daikichi_vote.save
    log_in_as(@member_user)
    patch daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote),
          params: { daikichi_vote: { daikichi_form_id: @daikichi_vote.daikichi_form_id,
                                     one_point_music_ids: @daikichi_vote.one_point_music_ids, three_point_music_ids: @daikichi_vote.three_point_music_ids, two_point_music_ids: @daikichi_vote.two_point_music_ids, user_id: @daikichi_vote.user_id } }
    assert_redirected_to daikichi_forms_path
    delete sessions_path
    log_in_as(@producer_user)
    patch daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote),
          params: { daikichi_vote: { daikichi_form_id: @daikichi_vote.daikichi_form_id,
                                     one_point_music_ids: @daikichi_vote.one_point_music_ids, three_point_music_ids: @daikichi_vote.three_point_music_ids, two_point_music_ids: @daikichi_vote.two_point_music_ids, user_id: @daikichi_vote.user_id } }
    assert_redirected_to daikichi_form_daikichi_vote_path(@daikichi_form, @daikichi_vote)
  end

  test 'producerのみ投票を削除できる' do
    @daikichi_vote.save
    log_in_as(@member_user)
    assert_no_difference('DaikichiVote.count') do
      delete daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote)
    end
    assert_redirected_to root_path
    delete sessions_path
    log_in_as(@producer_user)
    assert_difference('DaikichiVote.count', -1) do
      delete daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote)
    end
    assert_redirected_to daikichi_form_daikichi_votes_url(@daikichi_form)
  end

  test 'producer以外はフォームが閉じているときは投票できない' do
    log_in_as(@member_user)
    assert_no_difference('DaikichiVote.count') do
      post daikichi_form_daikichi_votes_url(@daikichi_form_closed),
           params: { daikichi_vote: { daikichi_form_id: @daikichi_vote_for_closed.daikichi_form_id,
                                      one_point_music_ids: @daikichi_vote_for_closed.one_point_music_ids, three_point_music_ids: @daikichi_vote_for_closed.three_point_music_ids, two_point_music_ids: @daikichi_vote_for_closed.two_point_music_ids, user_id: @member_user.id } }
    end
    assert_redirected_to daikichi_forms_path
    delete sessions_path
    log_in_as(@producer_user)
    assert_difference('DaikichiVote.count') do
      post daikichi_form_daikichi_votes_url(@daikichi_form_closed),
           params: { daikichi_vote: { daikichi_form_id: @daikichi_vote_for_closed.daikichi_form_id,
                                      one_point_music_ids: @daikichi_vote_for_closed.one_point_music_ids, three_point_music_ids: @daikichi_vote_for_closed.three_point_music_ids, two_point_music_ids: @daikichi_vote_for_closed.two_point_music_ids, user_id: @daikichi_vote_for_closed.user_id } }
    end
    assert_redirected_to daikichi_form_daikichi_vote_path(@daikichi_form_closed, DaikichiVote.last)
  end

  test 'すでに投票済みの場合投票を作成できずnewにもアクセスできない' do
    @daikichi_vote.save
    log_in_as(@producer_user)
    get new_daikichi_form_daikichi_vote_path(@daikichi_form)
    assert_redirected_to edit_daikichi_form_daikichi_vote_path(@daikichi_form, @daikichi_vote)
    assert_no_difference('DaikichiVote.count') do
      post daikichi_form_daikichi_votes_url(@daikichi_form),
           params: { daikichi_vote: { daikichi_form_id: @daikichi_vote.daikichi_form_id,
                                      one_point_music_ids: @daikichi_vote.one_point_music_ids, three_point_music_ids: @daikichi_vote.three_point_music_ids, two_point_music_ids: @daikichi_vote.two_point_music_ids, user_id: @daikichi_vote.user_id } }
    end
    assert_redirected_to edit_daikichi_form_daikichi_vote_path(@daikichi_form, @daikichi_vote)
  end
end

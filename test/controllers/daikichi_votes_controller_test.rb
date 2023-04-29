require 'test_helper'

class DaikichiVotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @daikichi_vote = daikichi_votes(:one)
    @daikichi_form = daikichi_forms(:one)
  end

  test 'should get index' do
    get daikichi_votes_url
    assert_response :success
  end

  test 'should get new' do
    get new_daikichi_form_daikichi_vote_url(@daikichi_form)
    assert_response :success
  end

  test 'should create daikichi_vote' do
    assert_difference('DaikichiVote.count') do
      post daikichi_form_daikichi_votes_url(@daikichi_form),
           params: { daikichi_vote: { daikichi_form_id: @daikichi_vote.daikichi_form_id,
                                      one_point_musics: @daikichi_vote.one_point_musics, three_point_musics: @daikichi_vote.three_point_musics, two_point_musics: @daikichi_vote.two_point_musics, user_id: @daikichi_vote.user_id } }
    end

    assert_redirected_to daikichi_form_daikichi_vote_url(@daikichi_form, DaikichiVote.last)
  end

  test 'should show daikichi_vote' do
    get daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote)
    assert_response :success
  end

  test 'should get edit' do
    get edit_daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote)
    assert_response :success
  end

  test 'should update daikichi_vote' do
    patch daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote),
          params: { daikichi_vote: { daikichi_form_id: @daikichi_vote.daikichi_form_id,
                                     one_point_musics: @daikichi_vote.one_point_musics, three_point_musics: @daikichi_vote.three_point_musics, two_point_musics: @daikichi_vote.two_point_musics, user_id: @daikichi_vote.user_id } }
    assert_redirected_to daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote)
  end

  test 'should destroy daikichi_vote' do
    assert_difference('DaikichiVote.count', -1) do
      delete daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote)
    end

    assert_redirected_to daikichi_votes_url
  end
end

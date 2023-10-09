require 'application_system_test_case'

class DaikichiVotesTest < ApplicationSystemTestCase
  setup do
    @daikichi_vote = daikichi_votes(:one)
    @daikichi_form = daikichi_forms(:daikichi100)
  end

  test 'visiting the index' do
    visit daikichi_votes_url
    assert_selector 'h1', text: 'Daikichi votes'
  end

  test 'should create daikichi vote' do
    visit daikichi_votes_url
    click_on 'New daikichi vote'

    fill_in 'Daikichi form', with: @daikichi_vote.daikichi_form_id
    fill_in 'One point music ids', with: @daikichi_vote.one_point_music_ids
    fill_in 'Three point music ids', with: @daikichi_vote.three_point_music_ids
    fill_in 'Two point music ids', with: @daikichi_vote.two_point_music_ids
    fill_in 'User', with: @daikichi_vote.user_id
    click_on 'Create Daikichi vote'

    assert_text 'Daikichi vote was successfully created'
    click_on 'Back'
  end

  test 'should update Daikichi vote' do
    visit daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote)
    click_on 'Edit this daikichi vote', match: :first

    fill_in 'Daikichi form', with: @daikichi_vote.daikichi_form_id
    fill_in 'One point music ids', with: @daikichi_vote.one_point_music_ids
    fill_in 'Three point music ids', with: @daikichi_vote.three_point_music_ids
    fill_in 'Two point music ids', with: @daikichi_vote.two_point_music_ids
    fill_in 'User', with: @daikichi_vote.user_id
    click_on 'Update Daikichi vote'

    assert_text 'Daikichi vote was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Daikichi vote' do
    visit daikichi_form_daikichi_vote_url(@daikichi_form, @daikichi_vote)
    click_on 'Destroy this daikichi vote', match: :first

    assert_text 'Daikichi vote was successfully destroyed'
  end
end

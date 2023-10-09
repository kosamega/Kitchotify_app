require 'application_system_test_case'

class DaikichiFormsTest < ApplicationSystemTestCase
  setup do
    @daikichi_form = daikichi_forms(:daikichi100)
  end

  test 'visiting the index' do
    visit daikichi_forms_url
    assert_selector 'h1', text: 'Daikichi forms'
  end

  test 'should create daikichi form' do
    visit daikichi_forms_url
    click_on 'New daikichi form'

    fill_in 'one_point', with: @daikichi_form.one_point
    fill_in 'two_point', with: @daikichi_form.two_point
    fill_in 'three_point', with: @daikichi_form.three_point
    fill_in 'Music ids for voting', with: @daikichi_form.music_ids_for_voting
    check 'form_closed' if @daikichi_form.form_closed
    fill_in 'Name', with: @daikichi_form.name
    click_on 'Create Daikichi form'

    assert_text 'Daikichi form was successfully created'
    click_on 'Back'
  end

  test 'should update Daikichi form' do
    visit daikichi_form_url(@daikichi_form)
    click_on 'Edit this daikichi form', match: :first

    fill_in 'one_point', with: @daikichi_form.one_point
    fill_in 'two_point', with: @daikichi_form.two_point
    fill_in 'three_point', with: @daikichi_form.three_point
    fill_in 'Music ids for voting', with: @daikichi_form.music_ids_for_voting
    check 'form_closed' if @daikichi_form.form_closed
    fill_in 'Name', with: @daikichi_form.name
    click_on 'Update Daikichi form'

    assert_text 'Daikichi form was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Daikichi form' do
    visit daikichi_form_url(@daikichi_form)
    click_on 'Destroy this daikichi form', match: :first

    assert_text 'Daikichi form was successfully destroyed'
  end
end

require 'test_helper'

class DaikichiFormsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @daikichi_form = daikichi_forms(:one)
  end

  test 'should get index' do
    get daikichi_forms_url
    assert_response :success
  end

  test 'should get new' do
    get new_daikichi_form_url
    assert_response :success
  end

  test 'should create daikichi_form' do
    assert_difference('DaikichiForm.count') do
      post daikichi_forms_url,
           params: { daikichi_form: { one_point: @daikichi_form.one_point, two_point: @daikichi_form.two_point,
                                      three_point: @daikichi_form.three_point, albums_for_voting: @daikichi_form.albums_for_voting, closed: @daikichi_form.closed, name: @daikichi_form.name } }
    end

    assert_redirected_to daikichi_form_url(DaikichiForm.last)
  end

  test 'should show daikichi_form' do
    get daikichi_form_url(@daikichi_form)
    assert_response :success
  end

  test 'should get edit' do
    get edit_daikichi_form_url(@daikichi_form)
    assert_response :success
  end

  test 'should update daikichi_form' do
    patch daikichi_form_url(@daikichi_form),
          params: { daikichi_form: { one_point: @daikichi_form.one_point, two_point: @daikichi_form.two_point,
                                     three_point: @daikichi_form.three_point, albums_for_voting: @daikichi_form.albums_for_voting, closed: @daikichi_form.closed, name: @daikichi_form.name } }
    assert_redirected_to daikichi_form_url(@daikichi_form)
  end

  test 'should destroy daikichi_form' do
    assert_difference('DaikichiForm.count', -1) do
      delete daikichi_form_url(@daikichi_form)
    end

    assert_redirected_to daikichi_forms_url
  end
end

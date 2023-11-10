require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:admin_user)
    @album = albums(:album1)
    log_in_as(@admin_user)
  end

  test 'ホーム描写' do
    get root_path
    assert_response :success
    assert_select 'title', 'Kitchotify - Home'
  end

  test 'インデックス情報登録フォームのバナーが適切に表示される' do
    patch album_path(@album), params: { album: { kiki_taikai_date: Time.zone.today.ago(15.days) } }
    @album.reload
    get root_path
    assert_select 'a[href=?]', new_album_music_path(@album), count: 0
    patch album_path(@album), params: { album: { kiki_taikai_date: Time.zone.today.ago(14.days) } }
    @album.reload
    get root_path
    assert_select 'a[href=?]', new_album_music_path(@album), @album.name
  end
end

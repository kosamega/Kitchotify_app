require 'test_helper'

class Api::AlbumsCreateApiTest < ActionDispatch::IntegrationTest
  def setup
    @album = albums(:album1)
  end

  test 'tokenが不正な場合401を返す' do
    post api_albums_path, params: { name: 'new_album', kiki_taikai_date: '2099-01-01' }
    assert_response 401
    res = JSON.parse(response.body)
    assert_equal ['tokenが間違っています'], res['messages']
  end

  test 'パラメータにnameが足らないときは400を返す' do
    post api_albums_path, headers: { Authorization: "Bearer #{ENV.fetch('KITCHOTIFY_CREATE_API_TOKEN')}" },
                          params: { kiki_taikai_date: '2099-01-01' }
    assert_response 400
    res = JSON.parse(response.body)
    assert_equal ['nameが足りません'], res['messages']
  end

  test 'パラメータにkiki_taikai_dateが足らないときは400を返す' do
    post api_albums_path, headers: { Authorization: "Bearer #{ENV.fetch('KITCHOTIFY_CREATE_API_TOKEN')}" },
                          params: { name: 'new_album' }
    assert_response 400
    res = JSON.parse(response.body)
    assert_equal ['kiki_taikai_dateが足りません'], res['messages']
  end

  test '同名のアルバムが存在している場合409を返す' do
    post api_albums_path, headers: { Authorization: "Bearer #{ENV.fetch('KITCHOTIFY_CREATE_API_TOKEN')}" },
                          params: { name: @album.name, kiki_taikai_date: '2099-01-01' }
    assert_response 409
    res = JSON.parse(response.body)
    assert_equal ['Nameはすでに存在します'], res['messages']
  end

  test '成功したときは200を返す' do
    assert_difference 'Album.count', 1 do
      post api_albums_path, headers: { Authorization: "Bearer #{ENV.fetch('KITCHOTIFY_CREATE_API_TOKEN')}" },
                            params: { name: 'new_album', kiki_taikai_date: '2099-01-01' }
    end
    assert_response 200
    @new_album = Album.find_by(name: 'new_album')
    res = JSON.parse(response.body)
    assert_equal @new_album.name, res['album']['name']
    assert_equal @new_album.kiki_taikai_date.strftime('%Y-%m-%d'), res['album']['kiki_taikai_date']
    assert_equal new_album_music_url(@new_album), res['album']['form_url']
  end
end

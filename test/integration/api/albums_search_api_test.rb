require 'test_helper'

class Api::AlbumsSearchApiTest < ActionDispatch::IntegrationTest
  def setup
    @album = albums(:album1)
  end 

  test "tokenが不正な場合401を返す" do
    get api_albums_path , params: {name: @album.name}
    assert_response 401
    res = JSON.parse(response.body)
    assert_equal ['tokenが間違っています'], res['messages']
  end

  test 'パラメータにnameが足らないときは400を返す' do
    get api_albums_path, headers: { 'Authorization': "Bearer #{ENV.fetch('KITCHOTIFY_SEARCH_API_TOKEN')}" }
    assert_response 400
    res = JSON.parse(response.body)
    assert_equal ['nameが足りません'], res['messages']
  end

  test '成功したときは200を返す' do
    get api_albums_path, headers: { 'Authorization': "Bearer #{ENV.fetch('KITCHOTIFY_SEARCH_API_TOKEN')}" }, params: {name: @album.name}
    assert_response 200
    res = JSON.parse(response.body)
    assert_equal @album.name, res['albums'][0]['name']
    assert_equal @album.kiki_taikai_date, res['albums'][0]['kiki_taikai_date']
    assert_equal album_url(@album), res['albums'][0]['url']
  end
end

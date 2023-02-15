require 'test_helper'

class ArtistsSearchApiTest < ActionDispatch::IntegrationTest
  def setup
    @artist = artists(:artist1)
  end

  test 'tokenが不正な場合401を返す' do
    get api_artists_path, params: { name: @artist.name }
    assert_response 401
    res = JSON.parse(response.body)
    assert_equal ['tokenが間違っています'], res['messages']
  end

  test 'パラメータにnameが足らないときは400を返す' do
    get api_artists_path, headers: { Authorization: "Bearer #{ENV.fetch('KITCHOTIFY_SEARCH_API_TOKEN')}" }
    assert_response 400
    res = JSON.parse(response.body)
    assert_equal ['nameが足りません'], res['messages']
  end

  test '成功したときは200を返す' do
    get api_artists_path, headers: { Authorization: "Bearer #{ENV.fetch('KITCHOTIFY_SEARCH_API_TOKEN')}" },
                          params: { name: @artist.name }
    assert_response 200
    res = JSON.parse(response.body)
    assert_equal @artist.name, res['artists'][0]['name']
    assert_equal @artist.bio, res['artists'][0]['bio']
    assert_equal artist_url(@artist), res['artists'][0]['url']
  end
end

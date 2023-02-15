require 'test_helper'

class Api::MusicsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @music = musics(:music1)
  end 
  
  test "tokenが不正な場合401を返す" do
    get api_musics_path , params: {name: @music.name}
    assert_response 401
    res = JSON.parse(response.body)
    assert_equal ['tokenが間違っています'], res['messages']
  end

  test 'パラメータにnameが足らないときは400を返す' do
    get api_musics_path, headers: { 'Authorization': "Bearer #{ENV.fetch('KITCHOTIFY_API_TOKEN')}" }
    assert_response 400
    res = JSON.parse(response.body)
    assert_equal 'nameが足りません', res['messages']
  end

  test '成功したときは200を返す' do
    get api_musics_path, headers: { 'Authorization': "Bearer #{ENV.fetch('KITCHOTIFY_API_TOKEN')}" }, params: {name: @music.name}
    assert_response 200
    res = JSON.parse(response.body)
    expected_response = [{"name"=>@music.name, "album"=>@music.album.name, "track"=>@music.track, "artist"=>@music.artist.name, "url"=> album_music_url(@music.album, @music)}]
    assert_equal expected_response, res['musics']
  end
end

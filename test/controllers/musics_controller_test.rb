require 'test_helper'

class MusicsControllerTest < ActionDispatch::IntegrationTest
  def setup 
    @album = albums(:g171)
    @user = users(:kosamega)
    @artist = artists(:artist1)
  end

  test "ログインしていなくてもmusicを作成できる" do
    delete sessions_path
    assert_difference("Music.count") do
      post album_musics_path(@album), params: {music: {name: "hoge",
                                                      index_info: "インデックス情報",
                                                      artist_name: @artist.name}}
    end
  end

end

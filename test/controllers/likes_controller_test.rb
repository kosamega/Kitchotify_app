require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
    def setup
        @user = users(:kosamega)
        @music = musics(:waopo)
    end

  test 'ユーザーが有効' do
    assert @user.valid?
  end

    test "ログインしないとlikeを作成出来なく、するとできる" do
        post likes_path, params: {music_id: @music.id, user_id: @user.id}
        assert_not flash.empty?
        assert_redirected_to "/login"
        log_in_as(@user)
        assert_difference "Like.count", 1 do
            post likes_path, params: {music_id: @music.id, user_id: @user.id}
        end
    end
    
    test "ログインしないとlikeを削除できなく、するとできる" do
        log_in_as(@user)
        post likes_path, params: {music_id: @music.id, user_id: @user.id}
        like = Like.find_by(music_id: @music.id, user_id: @user.id)
        assert_difference "Like.count", -1 do
            delete like_path(like), params: {like_id: like.id}
        end
        delete "/logout"
        assert_not is_logged_in?
        delete like_path(like), params: {like_id: like.id}
        assert_not flash.empty?
        assert_redirected_to "/login"
    end
    
    test "ログインしないとlike一覧にアクセスできない" do
        get "/likes"
        assert_not flash.empty?
        assert_redirected_to "/login"
    end

end

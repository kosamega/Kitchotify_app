require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
    def setup
        @user = users(:kosamega)
        @like = @user.likes.build(music_id: 1)
    end

    test "ログインしないとlikeを作成出来ない" do
        post likes_path, params: {music_id: 1, user_id: 1}
        assert_not flash.empty?
        assert_redirected_to "/login"
    end
    
    test "ログインしないとlikeを削除できない" do
        delete like_path(1)
        assert_not flash.empty?
        assert_redirected_to "/login"
    end
    
    test "ログインしないとlike一覧にアクセスできない" do
        get "/likes"
        assert_not flash.empty?
        assert_redirected_to "/login"
    end

end

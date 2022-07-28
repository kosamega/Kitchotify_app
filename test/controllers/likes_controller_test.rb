require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
    def setup
        @user = users(:kosamega)
        @like = @user.likes.build(music_id: 1)
    end

    test "ログインしないとlikeを作成出来ない" do
        post "/likes/1/create"
        assert_not flash.empty?
        assert_redirected_to "/login"
    end
    
    test "ログインしないとlikeを削除できない" do
        delete "/likes/1/destroy"
        assert_not flash.empty?
        assert_redirected_to "/login"
    end
    
    test "ログインしないとlike一覧にアクセスできない" do
        get "/likes/index"
        assert_not flash.empty?
        assert_redirected_to "/login"
    end

end

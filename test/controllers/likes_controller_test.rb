require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
    def setup
        @user = users(:kosamega)
        @like = likes(:one)
    end

    test "ユーザーが有効" do
        assert @user.valid?
    end

    test "likeが有効" do
        assert @like.valid?
    end

    test "ログインしないとlikeを作成出来なく、するとできる" do
        post likes_path, params: {music_id: 1, user_id: 1}
        assert_not flash.empty?
        assert_redirected_to "/login"
        log_in_as(@user)
        assert_difference "Like.count", 1 do
            post likes_path, params: {music_id: 1, user_id: 1}
        end
    end
    
    test "ログインしないとlikeを削除できなく、するとできる" do
        delete like_path(@like)
        assert_not flash.empty?
        assert_redirected_to "/login"
        assert_difference "Like.count", -1 do
            delete like_path(@like)
        end
    end
    
    test "ログインしないとlike一覧にアクセスできない" do
        get "/likes"
        assert_not flash.empty?
        assert_redirected_to "/login"
    end

end

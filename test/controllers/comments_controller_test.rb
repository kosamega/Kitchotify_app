require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user1)
    @music = musics(:music1)
    @album = albums(:album1)
  end

  test '有効なユーザー' do
    assert @user.valid?
  end

  test '有効なアルバム' do
    assert @album.valid?
  end

  test '有効なコメントを作成' do
    log_in_as(@user)
    assert_difference 'Comment.count', 1 do
      post comments_path, params: { comment: { content: 'test', music_id: @music.id, album_id: @album.id } }
    end
  end

  test 'ログインしないとコメントできない' do
    assert_no_difference 'Comment.count' do
      post comments_path, params: { comment: { content: 'test', music_id: @music.id, album_id: @album.id } }
    end
  end

  test '空のコメントは無効' do
    log_in_as(@user)
    assert_no_difference 'Comment.count' do
      post comments_path, params: { comment: { content: '', music_id: @music.id, album_id: @album.id } }
    end
  end
end

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:kosamega)
  end

  test '有効なユーザー' do
    assert @user.valid?
  end

  test '有効なコメントを作成' do
    log_in_as(@user)
    assert_difference 'Comment.count', 1 do
      post comments_path, params: { comment: { content: 'test' }, music_id: 1 }
    end
  end

  test 'ログインしないとコメントできない' do
    assert_no_difference 'Comment.count' do
      post comments_path, params: { comment: { content: 'test' }, music_id: 1 }
    end
  end

  test '空のコメントは無効' do
    log_in_as(@user)
    assert_no_difference 'Comment.count' do
      post comments_path, params: { comment: { content: '' }, music_id: 1 }
    end
  end
end

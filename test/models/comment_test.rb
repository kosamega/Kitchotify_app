require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:user1)
    @music = musics(:music1)
    @comment = @user.comments.build(content: 'iijan', music_id: @music.id)
  end

  test 'ユーザーが有効' do
    assert @user.valid?
  end

  test 'コメントが有効' do
    assert @comment.valid?
  end

  test '内容が空でない' do
    @comment.content = '   '
    assert_not @comment.valid?
  end

  test 'user_idを持っている' do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

  test 'music_idを持っている' do
    @comment.music_id = nil
    assert_not @comment.valid?
  end
end

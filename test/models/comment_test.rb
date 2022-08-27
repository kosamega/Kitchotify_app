require "test_helper"

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:kosamega)
    @comment = @user.comments.build(content: "iijan", music_id: 1)
  end

  test "コメントが有効" do
    assert @comment.valid?
  end

  # test "内容が空でない" do
  #   @comment.content = "   "
  #   assert_not @comment.valid?
  # end

  # test "user_idを持っている" do
  #   @comment.user_id = nil
  #   assert_not @comment.valid?
  # end
  
  # test "music_idを持っている" do
  #   @comment.music_id = nil
  #   assert_not @comment.valid?
  # end

end

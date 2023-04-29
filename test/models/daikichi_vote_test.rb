require 'test_helper'

class DaikichiVoteTest < ActiveSupport::TestCase
  def setup
    @form = DaikichiForm.new(name: 'touhyou', three_point: 1, two_point: 1, one_point: 2, closed: false,
                             albums_for_voting: [albums(:album1).id, albums(:album2).id])
    @vote = @form.daikichi_votes.build(user_id: users(:user1).id, three_point_musics: [musics(:music1).id],
                                       two_point_musics: [musics(:music2).id], one_point_musics: [musics(:music3).id, musics(:music4).id])
  end

  test 'formが有効' do
    assert @form.valid?
  end

  test '投票が有効' do
    assert @vote.valid?
  end

  test 'それぞれの点数の投票曲数がformのと一致する' do
    @vote.one_point_musics = [musics(:music3).id]
    assert_not @vote.valid?
  end

  test '投票対象曲にのみ投票している' do
    @vote.three_point_musics = [musics(:music5).id]
    assert_not @vote.valid?
  end

  test '重複して投票していない' do
    @vote.three_point_musics = [@vote.two_point_musics.first]
    assert_not @vote.valid?
  end
end

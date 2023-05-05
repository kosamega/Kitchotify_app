require 'test_helper'

class DaikichiVoteTest < ActiveSupport::TestCase
  def setup
    @form = DaikichiForm.new(name: 'touhyou', three_point: 1, two_point: 1, one_point: 2, form_closed: false, result_open: false,
                             music_ids_for_voting: [musics(:music1).id, musics(:music2).id, musics(:music3).id, musics(:music4).id])
    @vote = @form.daikichi_votes.build(user_id: users(:admin_user).id, three_point_music_ids: [musics(:music1).id],
                                       two_point_music_ids: [musics(:music2).id], one_point_music_ids: [musics(:music3).id, musics(:music4).id])
  end

  test 'formが有効' do
    assert @form.valid?
  end

  test '投票が有効' do
    assert @vote.valid?
  end

  test 'それぞれの点数の投票曲数がformのと一致する' do
    @vote.one_point_music_ids = [musics(:music3).id]
    assert_not @vote.valid?
  end

  test '投票対象曲にのみ投票している' do
    @vote.three_point_music_ids = [musics(:music5).id]
    assert_not @vote.valid?
  end

  test '重複して投票していない' do
    @vote.three_point_music_ids = [@vote.two_point_music_ids.first]
    assert_not @vote.valid?
  end
end

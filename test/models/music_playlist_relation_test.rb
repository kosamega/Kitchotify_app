require 'test_helper'

class MusicPlaylistRelationTest < ActiveSupport::TestCase
  def setup
    @relation = MusicPlaylistRelation.new(playlist_id: playlists(:playlist1).id, music_id: musics(:music1).id)
  end

  test 'relationが有効' do
    assert @relation.valid?
  end

  test 'playlist_idを持っている' do
    @relation.playlist_id = nil
    assert_not @relation.valid?
  end

  test 'music_idを持っている' do
    @relation.music_id = nil
    assert_not @relation.valid?
  end
end

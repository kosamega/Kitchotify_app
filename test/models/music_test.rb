require 'test_helper'

class MusicTest < ActiveSupport::TestCase
  def setup
    @music = musics(:music1)
  end

  test 'musicが有効' do
    @music.valid?
  end

  test 'nameは空でない' do
    @music.name = ''
    assert_not @music.valid?
  end

  test 'nameは100文字以下' do
    @music.name = 'a' * 101
    assert_not @music.valid?
  end

  test 'trackは1000より小さい' do
    @music.track = 1000
    assert_not @music.valid?
  end
end

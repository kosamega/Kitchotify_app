require 'test_helper'

class ArtistTest < ActiveSupport::TestCase
  def setup
    @artist = artists(:artist1)
  end

  test '有効なアルバム' do
    assert @artist.valid?
  end

  test '名前が空でない' do
    @artist.name = '   '
    assert_not @artist.valid?
  end

  test '名前が一意' do
    duplicate_artist = @artist.dup
    assert_not duplicate_artist.valid?
  end
end

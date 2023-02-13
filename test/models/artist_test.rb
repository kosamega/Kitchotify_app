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
end

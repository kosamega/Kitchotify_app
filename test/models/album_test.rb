require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  def setup
    @album = albums(:album1)
  end

  test '有効なアルバム' do
    assert @album.valid?
  end

  test '名前が空でない' do
    @album.name = '   '
    assert_not @album.valid?
  end
end

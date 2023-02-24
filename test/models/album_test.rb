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

  test 'nameがunique' do
    duplicate_album = @album.dup
    assert_not duplicate_album.valid?
  end

  test 'kiki_taikai_dateが空でない' do
    @album.kiki_taikai_date = ''
    assert_not @album.valid?
  end

  test 'kiki_taikai_dateがyyyy-MM-dd形式なら通す' do
    valid_dates = %w[2022-01-30 2022-11-01]
    valid_dates.each do |date|
      @album.kiki_taikai_date = date
      assert @album.valid?
    end
  end

  test 'kiki_taikai_dateがyyyy-MM-dd形式でなかったらはじく' do
    invalid_dates = %w[2022-00-21 2022--00-21 2022-02-31]
    invalid_dates.each do |date|
      @album.kiki_taikai_date = date
      assert_not @album.valid?, "#{date.inspect} should be invalid"
    end
  end
end

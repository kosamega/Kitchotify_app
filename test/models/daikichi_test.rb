require 'test_helper'

class DaikichiTest < ActiveSupport::TestCase
  def setup
    @daikichi = daikichis(:daikichi1)
  end

  test '有効な大吉' do
    assert @daikichi.valid?
  end

  test '名前が空でない' do
    @daikichi.name = '   '
    assert_not @daikichi.valid?
  end

  test 'nameがunique' do
    duplicate_album = @daikichi.dup
    assert_not duplicate_album.valid?
  end

  test 'counting_votes_dateが空でない' do
    @daikichi.counting_votes_date = ''
    assert_not @daikichi.valid?
  end

  test 'counting_votes_dateがyyyy-MM-dd形式なら通す' do
    valid_dates = %w[2022-01-30 2022-11-01]
    valid_dates.each do |date|
      @daikichi.counting_votes_date = date
      assert @daikichi.valid?
    end
  end

  test 'counting_votes_dateがyyyy-MM-dd形式でなかったらはじく' do
    invalid_dates = %w[2022-00-21 2022--00-21 2022-02-31]
    invalid_dates.each do |date|
      @daikichi.counting_votes_date = date
      assert_not @daikichi.valid?, "#{date.inspect} should be invalid"
    end
  end
end

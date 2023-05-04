require 'test_helper'

class DaikichiFormTest < ActiveSupport::TestCase
  def setup
    @form = DaikichiForm.new(name: 'touhyou', three_point: 1, two_point: 1, one_point: 2, closed: false,
      albums_for_voting: [albums(:album1).id, albums(:album2).id])
  end

  test 'formが有効' do
    assert @form.valid?
  end

  # test '名前が一意' do
  #   duplicate_form = DaikichiForm.new(name: 'touhyou', three_point: 1, two_point: 1, one_point: 2, closed: false,
  #     albums_for_voting: [albums(:album1).id, albums(:album2).id])
  #   assert_not duplicate_form.valid?
  # end

  test '名前が空でない' do
    @form.name = ''
    assert_not @form.valid?
  end
end

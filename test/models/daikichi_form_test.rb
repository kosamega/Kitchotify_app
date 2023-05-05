require 'test_helper'

class DaikichiFormTest < ActiveSupport::TestCase
  def setup
    @form = DaikichiForm.new(name: 'touhyou', three_point: 1, two_point: 1, one_point: 2, form_closed: false,
                             music_ids_for_voting: [musics(:music1).id, musics(:music2).id, musics(:music3).id, musics(:music4).id])
  end

  test 'formが有効' do
    assert @form.valid?
  end

  # test '名前が一意' do
  #   duplicate_form = DaikichiForm.new(name: 'touhyou', three_point: 1, two_point: 1, one_point: 2, form_closed: false,
  #     music_ids_for_voting: [musics(:music1).id, musics(:music2).id, musics(:music3).id, musics(:music4).id])
  #   assert_not duplicate_form.valid?
  # end

  test '名前が空でない' do
    @form.name = ''
    assert_not @form.valid?
  end
end

require 'test_helper'

class DesignerTest < ActiveSupport::TestCase
  def setup
    @designer = designers(:designer1)
  end

  test "名前が一意" do
    duplicate_designer = @designer.dup
    assert_not duplicate_designer.valid?
  end

  test "名前が空でない" do
    @designer.name = ""
    assert_not @designer.valid?
  end
end

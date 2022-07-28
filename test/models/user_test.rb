require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:kosamega)
  end

  test "@userがvalid" do
    assert @user.valid?
  end

  test "nameが存在" do
    @user.name = "  "
    assert_not @user.valid?
  end

  test "emailが存在" do
    @user.email = "  "
    assert_not @user.valid?
  end
  
end

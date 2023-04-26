require "test_helper"

class UserArtistOwnershipTest < ActiveSupport::TestCase
  def setup
    @ownership = user_artist_ownerships(:one)
  end

  test "ownershipが有効" do
    assert @ownership.valid?
  end

  test '同一userを同一artistに追加できない' do
    duplicate_ownership = @ownership.dup
    assert_not duplicate_ownership.valid?
  end
end

require 'test_helper'

class UserArtistOwnershipTest < ActiveSupport::TestCase
  def setup
    @ownership = user_artist_ownerships(:one)
  end

  test 'ownershipが有効' do
    assert @ownership.valid?
  end
end

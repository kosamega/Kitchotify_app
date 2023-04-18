class UserArtistOwnershipsController < ApplicationController
  before_action :logged_in_user
  before_action :set_user_artist_ownership, only: %i[destroy]

  def create
    UserArtistOwnership.create(user_id: params[:user_id], artist_id: params[:artist_id])
  end

  def destroy
    @user_artist_ownership.destroy
  end

  private
  def set_user_artist_ownership
    @user_artist_ownership = UserArtistOwnership.find(prams[:id])
  end
end

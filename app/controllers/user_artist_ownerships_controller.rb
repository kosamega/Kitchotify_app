class UserArtistOwnershipsController < ApplicationController
  before_action :logged_in_user
  before_action :set_ownership, only: %i[destroy]

  def create
    @ownership = UserArtistOwnership.new(ownership_params)
    if @ownership.save
      @save = true
      respond_to do |format|
        format.html { redirect_to root_url }
        format.js
      end
    else
      @save = false
      respond_to do |format|
        format.html { redirect_to root_url }
        format.js
      end
    end
  end

  def destroy
    user = @ownership.user
    artist = @ownership.artist 
    @ownership.destroy
    render json: {message: "#{user.name}と#{artist.name}の紐付けを削除しました", user: user.name, user_id: user.id}
  end

  private
  def set_ownership
    @ownership = UserArtistOwnership.find(params[:id])
  end

  def ownership_params
    params.require(:user_artist_ownership).permit(:user_id, :artist_id)
  end
end

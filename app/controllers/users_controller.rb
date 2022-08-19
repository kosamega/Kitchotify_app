class UsersController < ApplicationController
  before_action :logged_in_user

  def show
    @user = User.find_by(id: params[:id])
    @playlists = @user.playlists
  end

  def edit
  end

  def update
    current_user.update(user_params)
    redirect_to "/users/#{current_user.id}"
  end

  def index
    @users = User.all
  end

  private
    def user_params
      params.require(:user).permit(:name, :bio)
    end

end

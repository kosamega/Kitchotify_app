class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :not_kitchonkun, only: %i[edit update]
  before_action :admin_user, only: %i[new create]
  before_action :correct_user_edit, only: %i[edit update]

  def index
    @users = User.all
  end

  def show
    if (@user = User.find_by(id: params[:id]))
      @playlists = @user.playlists
    else
      render 'shared/not_found'
    end
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザー登録に成功しました'
    else
      flash[:danger] = 'ユーザー登録に失敗しました'
    end
    redirect_to new_user_path
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      flash[:danger] = 'すでに存在する名前です'
      redirect_to edit_user_path(current_user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :bio)
  end

  def correct_user_edit
    @user = User.find_by(id: params[:id])
    redirect_to('/') unless @user == current_user
  end
end

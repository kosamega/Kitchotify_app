class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :not_kitchonkun, only: [:edit, :update]
  before_action :adimin_user, only: [:new, :create]
  before_action :correct_user_edit, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash.now[:success] = "ユーザー登録に成功しました"
      render 'users/new'
    else
      flash.now[:danger] = "ユーザー登録に失敗しました"
      render 'users/new'
    end
  end

  def show
    if @user = User.find_by(id: params[:id]) 
      @playlists = @user.playlists
    else
      render "shared/not_found"
    end
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to "/users/#{current_user.id}"
    else
      flash[:danger] = "すでに存在する名前です"
      redirect_to edit_user_path(current_user)
    end
  end

  def index
    @users = User.all
  end

  private
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :bio)
    end

    def correct_user_edit
      @user = User.find_by(id: params[:id])
      redirect_to("/") unless @user == current_user
    end
end

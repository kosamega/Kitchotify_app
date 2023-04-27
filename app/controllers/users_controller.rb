class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index show edit update destroy]
  before_action :not_kitchonkun, only: %i[edit update]
  before_action :set_user, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[edit update]

  def index
    @users = User.all
  end

  def show
    @playlists = @user.playlists
    @artists = @user.artists
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    if params[:auth][:kitchon_server_password] != ENV['KITCHON_SERVER_PASSWORD']
      flash.now[:danger] = 'サーバーのパスワードが間違っています'
      return render 'new'
    end

    if @user.save
      flash[:success] = 'ユーザー登録に成功しました'
      log_in @user
      redirect_to root_path
    else
      flash.now[:danger] = 'ユーザー登録に失敗しました'
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      return if user_params[:volume].present?

      if user_params[:editor].present?
        flash[:success] = "エディターモードを#{@user.editor? ? 'オン' : 'オフ'}にしました"
        redirect_back_or root_path
      else
        flash[:success] = 'ユーザーを更新しました'
        redirect_to user_path(current_user)
      end
    else
      flash[:danger] = @user.errors.full_messages.join('<br>')
      redirect_to edit_user_path(current_user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :bio, :editor, :join_date, :volume)
  end

  def correct_user
    redirect_to root_path unless @user == current_user
  end

  def set_user
    @user = User.find(params[:id])
  end

  def admin_user_or_kitchonkun
    return if current_user.admin? || current_user.name == 'kitchonkun'

    flash[:danger] = '管理者かkitchonkunアカウントでしかできない操作です'
    redirect_to root_path
  end
end

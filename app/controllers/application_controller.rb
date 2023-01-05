class ApplicationController < ActionController::Base
  before_action :store_location
  include SessionsHelper
  # 最後にgetリクエストを送ったURLを覚えておく
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  # ユーザーのログインを確認する
  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = 'ログインしてください'
    redirect_to '/login'
  end

  def not_kitchonkun
    return unless current_user == User.find(2)

    store_location
    flash[:danger] = 'ログインしてください'
    redirect_to '/login'
  end

  def correct_user
    @user = Playlist.find_by(id: params[:id]).user
    redirect_to('/') unless @user == current_user
  end

  def admin_user
    return if current_user.admin?

    flash[:danger] = '管理者のみ有効な操作です'
    redirect_to('/')
  end

  def admin_or_seisan
    return if current_user.admin? || current_user.role = seisan
    flash[:danger] = '管理者か生産のみ有効な操作です'
    redirect_to('/')
  end
end

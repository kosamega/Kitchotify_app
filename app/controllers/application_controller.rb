class ApplicationController < ActionController::Base
  before_action :store_location
  protect_from_forgery with: :null_session
  
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
    redirect_to new_sessions_path
  end

  def not_kitchonkun
    return unless current_user.name == 'kitchonkun'

    store_location
    flash[:danger] = 'ログインしてください'
    redirect_to new_sessions_path
  end

  def correct_user
    @user = Playlist.find_by(id: params[:id]).user
    redirect_to root_path unless @user == current_user
  end

  def admin_user
    return if current_user.admin?

    flash[:danger] = '管理者のみ有効な操作です'
    redirect_to root_path
  end

  def set_current_user_playlists
    @playlists = current_user&.playlists
  end

  def set_current_user_volume
    gon.user = { id: current_user.id, volume: current_user.volume }
  end

  def set_csrf_token_header
    response.set_header('X-CSRF-Token', form_authenticity_token)
  end
end

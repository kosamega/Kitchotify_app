class ApplicationController < ActionController::Base
  before_action :store_location
  before_action :set_notification

  include SessionsHelper

  # 最後にgetリクエストを送ったURLを覚えておく
  def store_location
    session[:forwarding_url] = request.original_url if request.get? && request.path != new_sessions_path
  end

  # ユーザーのログインを確認する
  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = 'ログインしてください'
    redirect_to new_sessions_path(twitter_info: @twitter_info)
  end

  def not_kitchonkun
    return unless current_user.role_kitchonkun?

    store_location
    flash[:danger] = 'ログインしてください'
    redirect_to new_sessions_path
  end

  def correct_user
    @user = Playlist.find_by(id: params[:id]).user
    redirect_to root_path unless @user == current_user
  end

  def admin_user
    return if current_user.role_admin?

    flash[:danger] = '管理者のみ有効な操作です'
    redirect_to root_path
  end

  def representative_user
    return if current_user.role_is_a_representative?

    flash[:danger] = '代表のみ有効な操作です'
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

  def set_notification
    request.env['exception_notifier.exception_data'] = { 'server' => request.env['SERVER_NAME'] }
    # can be any key-value pairs
  end
end

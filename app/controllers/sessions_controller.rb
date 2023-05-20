class SessionsController < ApplicationController
  before_action :logged_in_user, only: :destroy

  def new; end

  def create
    user = User.find_by(name: params[:session][:name])
    if user&.authenticate(params[:session][:password])
      log_in user
      return redirect_to root_path if user.role_kitchonkun?

      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to root_path
    else
      @name = params[:session][:name]
      @password = params[:session][:password]
      flash.now[:danger] = 'ユーザーネームかパスワードが間違っています'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to new_sessions_path
  end
end

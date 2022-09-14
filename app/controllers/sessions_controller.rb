class SessionsController < ApplicationController
  before_action :logged_in_user, only: :destroy

  def new
    @name = ""
    @password = ""
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      log_in user
      unless user.id == 2
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      end
      redirect_to "/"
    else
      @name = params[:session][:name]
      @password = params[:session][:password]
      flash.now[:danger] = "ユーザーネームかパスワードが間違っています"
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to "/login"
  end
end

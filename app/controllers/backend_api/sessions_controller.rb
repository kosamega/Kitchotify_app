class BackendApi::SessionsController < ApplicationController
  before_action :logged_in_user, only: %i[destroy show]

  def new; end

  def show
    set_csrf_token
    render json: {}, statul: :ok
  end

  def create
    @user = User.find_by(name: params[:session][:name])
    if @user&.authenticate(params[:session][:password])
      log_in @user
      return if @user.name == 'kitchonkun'
      p 'success'
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
    else
      @name = params[:session][:name]
      @password = params[:session][:password]
      p 'unsuccess'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to new_sessions_path
  end
end

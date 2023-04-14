class BackendApi::UsersController < ApplicationController
  before_action :logged_in_user
  
  def show
    render json: {
      user: current_user
    }, status: :ok
  end
end

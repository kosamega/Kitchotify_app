class Api::Base < ApplicationController
  before_action :authenticate

  def authenticate
    authenticate_api_token || render_unauthorized
  end

  def authenticate_api_token
    authenticate_with_http_token do |token|
      token == ENV.fetch('KITCHOTIFY_API_TOKEN')
    end
  end

  def render_unauthorized
    render json: { messages: ['tokenが間違っています'] }, status: :unauthorized
  end

  def name_exist?
    return render json: { messages: 'nameが足りません' }, status: :bad_request if params[:name].nil?
  end
end

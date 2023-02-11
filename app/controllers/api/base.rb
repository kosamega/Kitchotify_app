class Api::Base < ApplicationController
  before_action :authenticate
  before_action :parameter_exist?
  
  def authenticate
    authenticate_api_token || render_unauthorized
  end
  
  def authenticate_api_token
    authenticate_with_http_token do |token|
      token == ENV.fetch('KITCHOTIFY_API_TOKEN')
    end
  end
  
  def render_unauthorized
    render json: { status: '401', error: 'tokenが間違っています' }
  end
  
  def parameter_exist?
    return render json: { status: '400', error: 'nameが足りません' } if params[:name].nil?
  end
end
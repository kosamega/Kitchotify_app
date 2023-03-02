class Api::Base < ApplicationController
  protect_from_forgery with: :null_session

  def authenticate_search_api
    authenticate_search_api_token || render_unauthorized
  end

  def authenticate_search_api_token
    authenticate_with_http_token do |token|
      token == ENV.fetch('KITCHOTIFY_SEARCH_API_TOKEN')
    end
  end

  def authenticate_create_api
    authenticate_create_api_token || render_unauthorized
  end

  def authenticate_create_api_token
    authenticate_with_http_token do |token|
      token == ENV.fetch('KITCHOTIFY_CREATE_API_TOKEN')
    end
  end

  def render_unauthorized
    render json: { messages: ['tokenが間違っています'] }, status: :unauthorized
  end

  def name_exist?
    return render json: { messages: ['nameが足りません'] }, status: :bad_request if params[:name].nil?
  end

  def kiki_taikai_date_exist?
    return render json: { messages: ['kiki_taikai_dateが足りません'] }, status: :bad_request if params[:kiki_taikai_date].nil?
  end
end

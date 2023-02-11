class Api::Base < ApplicationController
  before_action :parameter_exist?
  before_action :Authenticate
  
  def parameter_exist?
    return render json: { status: '400', error: 'nameとapi_keyが足りません' } if params[:name].nil? && params[:api_key].nil?
    return render json: { status: '400', error: 'nameが足りません' } if params[:name].nil?
    return render json: { status: '400', error: 'api_keyが足りません' } if params[:api_key].nil?
  end
    
  def Authenticate
    return render json: { status: '401', error: 'api_keyが間違っています' } if params[:api_key] != ENV.fetch('KITCHOTIFY_API_KEY')
  end
end
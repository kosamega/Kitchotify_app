class Api::Base < ApplicationController
  before_action :parameter_exist?
  before_action :Authenticate
  
  def parameter_exist?
    return render json: { status: '400', error: 'nameとAccessKeyが足りません' } if params[:name].nil? && params[:AccessKey].nil?
    return render json: { status: '400', error: 'nameが足りません' } if params[:name].nil?
    return render json: { status: '400', error: 'AccessKeyが足りません' } if params[:AccessKey].nil?
  end
    
  def Authenticate
    return render json: { status: '401', error: 'AccessKeyが間違っています' } if params[:AccessKey] != ENV.fetch('KITCHOTIFY_API_KEY')
  end
end
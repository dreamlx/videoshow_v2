class Api::V2::OauthController < Api::BaseController
  CALLBACK = "http://api.videoshowapp.com:8087/api/v2/oauth/callback"

  def index
  end

  def connect
    redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK, scope: 'comments likes basic')
  end

  def callback
    #response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK)
    #session[:access_token] = response.access_token
    session[:access_token] = '1111111223'

    redirect_to '/home/callbacki'
  end

end
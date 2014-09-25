class Api::V1::OauthController < Api::BaseController
  CALLBACK = "http://api.videoshowapp.com:8087/api/v1/oauth/callback"

  def index
  end

  def connect
    redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK, scope: 'comments likes basic')
  end

  def callback
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK)
    access_token = response.access_token
    session[:access_token] = access_token


    redirect_to '/home/callback?token='+access_token
  end

end
class Api::V1::OauthController < Api::BaseController
  #CALLBACK = "http://api.videoshowapp.com:8087/api/v1/oauth/callback"
  CALLBACK = "http://54.178.154.11:8087/api/v1/oauth/callback"
  
  #CALLBACK ='http://127.0.0.1:3000/api/v1/oauth/callback'
  def index
  end

  def connect
    redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK, scope: 'comments likes basic')
  end

  def callback
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK)
    session[:access_token] = response.access_token
    #TOKEN = '789981918.80d957c.f408bb1006844250907d9d2a34df66c4'
    #render json: {code: 'success', result: response}
    redirect_to '/home/callback'
  end

end
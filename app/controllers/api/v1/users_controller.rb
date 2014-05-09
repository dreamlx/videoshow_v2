class Api::V1::UsersController < Api::BaseController
  def feed
    client = Instagram.client(:access_token => session[:access_token])
    render json: client.to_json
  end


  def user_search
    instagrams = Instagram.user_search(params[:user])
    render json: instagrams.to_json
  end

  def user_profile
    instagrams = Instagram.user(params[:user_id])
    render json: instagrams.to_json
  end
  
end
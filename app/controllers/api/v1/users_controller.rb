class Api::V1::UsersController < Api::BaseController
  def feed
    client = Instagram.client(:access_token => session[:access_token])
    render json: client.to_json
  end
end
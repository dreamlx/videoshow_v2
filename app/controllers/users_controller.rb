class UsersController < ApplicationController
  def feed
    @user = Instagram.client(:access_token => session[:access_token])
  end
end

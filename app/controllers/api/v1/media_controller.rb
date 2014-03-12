class Api::V1::MediaController < Api::BaseController
  def popular
    instagrams = Instagram.media_popular
    render json: instagrams.to_json
  end

  def tag_search
    # tag_search
    instagrams = Instagram.tag_search(params[:tag])
    render json: instagrams.to_json
  end

  def tag_recent_media
    instagrams = Instagram.tag_recent_media
    render json: instagrams.to_json
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
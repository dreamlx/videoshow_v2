require 'timeout'

class Api::V1::MediaController < Api::BaseController
  def featured_collection
    page = params[:page]
    page = 15 if page.to_i > 15
        blacklist = []
    BlackList.all.each {|b| blacklist << b.username}
    instagrams = FeaturedVideo.filter_blacklist(blacklist).featured.has_video.instagram_desc.paginate(:page => page, per_page: 10)
    render json: instagrams.to_json, :callback => params[:callback]
  end

  def tag_recent_media
    page = params[:page]
    page = 15 if page.to_i > 15
        blacklist = []
    BlackList.all.each {|b| blacklist << b.username}
    instagrams = FeaturedVideo.filter_blacklist(blacklist).has_video.instagram_desc.paginate(:page => page, per_page: 10)
    render json: instagrams.to_json, :callback => params[:callback]
  end
  
  def popular
    instagrams = 'timeout'
    begin
    timeout(2) {
      instagrams = Instagram.media_popular
    }
    render json: instagrams.to_json
    rescue TimeoutError
       render json: "Timed Out".to_json
    end
  end

  def tag_search
    # tag_search
    #client = Instagram.client(:access_token => session[:access_token])
    instagrams = 'timeout'
    begin
      timeout(2) {
        instagrams = Instagram.tag_search(params[:tag])
      }
      render json: instagrams.to_json
    rescue TimeoutError
       render json: "Timed Out".to_json
    end
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
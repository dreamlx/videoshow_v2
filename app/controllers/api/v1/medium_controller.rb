require 'timeout'

class Api::V1::MediumController < Api::BaseController
  def featured #featured_collection
    page = params[:page]
    blist = BlackList.all.map{|b| b.username}
    instagrams = FeaturedVideo.filter_blacklist(blist).featured.has_video.instagram_desc.paginate(:page => page, per_page: 10)
    
    format_ins = []
    instagrams.each do |i|
      if i.check_me
        item = i.format_me
        format_ins << item
      end
    end

    render json: format_ins.to_json, :callback => params[:callback]
  end

  def recent #tag_recent_media
    page = params[:page]
    blist = BlackList.all.map{|b| b.username}
    instagrams = FeaturedVideo.filter_blacklist(blist).has_video.instagram_desc.paginate(:page => page, per_page: 10)
    # annotation test
    format_ins = []
    instagrams.each do |i|
      if i.check_me
        item = i.format_me
        format_ins << item
      end
    end

    render json: format_ins.to_json, :callback => params[:callback]
  end

  def show
    if params[:access_token].blank? or params[:id].blank?
      render json:  {code: 400, message: 'miss access_token'}
    else
      client = Instagram.client(:access_token => params[:access_token])
      result = client.media_item(params[:id])
      render json:  result
    end
  end

  def user_liked_media
    client = Instagram.client(:access_token => session[:access_token])
    user = client.user
    result2 = client.user_liked_media(count: 50)
    render json: result2
  end

  def likes
    if params[:access_token].blank? or params[:id].blank?
      render json:  {code: 400, message: 'miss access_token '}
    else
      client = Instagram.client(:access_token => params[:access_token])
      result2 = client.media_likes(params[:id])
      render json:  result2
    end
  end

  def like_media
    if params[:access_token].blank? or params[:id].blank?
      render json: {code: 400, message: 'miss access_token '}
    else
      client = Instagram.client(:access_token => params[:access_token])
      result2 = client.like_media(params[:id])
      item = FeaturedVideo.where(:'instagram_item.id' => params[:id]).first
      
      item.update_item
      render json:  {like_status: result2, media_item: item}
    end
  end

  def unlike_media
    if params[:access_token].blank? or params[:id].blank?
      render json: {code: 400, message: 'miss access_token '}
    else
      client = Instagram.client(:access_token => params[:access_token])
      result2 = client.unlike_media(params[:id])
      item = FeaturedVideo.where(:'instagram_item.id' => params[:id]).first
    
      item.update_item
      render json:  {like_status: result2, media_item: item}
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

end
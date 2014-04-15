require 'timeout'

class Api::V1::MediumController < Api::BaseController
  def featured #featured_collection
    page = params[:page]
    page = 15 if page.to_i > 15
        blacklist = []
    BlackList.all.each {|b| blacklist << b.username}
    instagrams = FeaturedVideo.filter_blacklist(blacklist).featured.has_video.instagram_desc.paginate(:page => page, per_page: 10)
    render json: instagrams.to_json, :callback => params[:callback]
  end

  def recent #tag_recent_media
    page = params[:page]
    page = 15 if page.to_i > 15
        blacklist = []
    BlackList.all.each {|b| blacklist << b.username}
    instagrams = FeaturedVideo.filter_blacklist(blacklist).has_video.instagram_desc.paginate(:page => page, per_page: 10)
    render json: instagrams.to_json, :callback => params[:callback]
  end

  def show
    if params[:access_token].blank? or params[:id].blank?
      render json:  {code: 400, message: 'miss access_token'}
    else
      url = "https://api.instagram.com/v1/media/#{params[:id]}?access_token=#{params[:access_token]}"
      result2 = JSON.parse(Typhoeus.get(url).body)
      render json:  result2
    end
  end

  def likes
    if params[:access_token].blank? or params[:id].blank?
      render json:  {code: 400, message: 'miss access_token '}
    else
      url = "https://api.instagram.com/v1/media/#{params[:id]}/likes?access_token=#{params[:access_token]}"
      result2 = JSON.parse(Typhoeus.get(url).body)
      render json:  result2
    end
  end

  def like_media
    if params[:access_token].blank? or params[:id].blank?
      render json: {code: 400, message: 'miss access_token '}
    else
      #todo
      url = "https://api.instagram.com/v1/media/#{params[:id]}"
      result2 = JSON.parse(Typhoeus.post(url, body: { access_token: params[:access_token] }).body)
      render json:  result2
    end
  end

  def unlike_media
    if params[:access_token].blank? or params[:id].blank?
      render json: {code: 400, message: 'miss access_token '}
    else
      client = Instagram.client(:access_token => params[:access_token])
      result  = client.unlike_media(params[:media_id])
      render json: result.to_json
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
require 'timeout'

class Api::V1::MediumController < Api::BaseController
  def featured #featured_collection
    page = params[:page].to_i
    format_ins = queryCache('Featured',page,10)
    Thread.new{ReqCount.list_req_count(page,0,1,0)}
    #ReqCount.list_req_count(page,0,1)
    #FeaturedVideo.recent()
    render json: format_ins.to_json, :callback => params[:callback]
  end

  # save Cache
  def queryCache(type ='Recent' , page =1 , cacheMin =10)
    format_ins = []
    configId = "Cache"+type+page.to_s
    #FeaturedVideo.recent('videoshowapp') 
    reqConfigCache = ReqConfigCache.where(:'configId' => configId).first
    if(reqConfigCache == nil )
      format_ins = queryPageFeaturedVideo(type,page)
      ReqConfigCache.create!(configId: configId, type: type,page:page,content: format_ins,update_time:Time.new)
    else
      format_ins = reqConfigCache.content
      if reqConfigCache.update_time < cacheMin.minutes.ago
        reqConfigCache.update_time=Time.new
        reqConfigCache.save
        Thread.new{
            #binding.pry
            format_ins = queryPageFeaturedVideo(type, page)  
            reqConfigCache.content=format_ins
            #reqConfigCache.update_time=Time.new
            reqConfigCache.save
        }
      end
    end    
    return format_ins
  end

  def queryPageFeaturedVideo(type ='Recent' , page =1)
    format_ins = []
    blist = BlackList.all.map{|b| b.username}
    case type
      when "Featured"
          #instagrams = FeaturedVideo.filter_blacklist(blist).featured.has_video.instagram_desc.paginate(:page => page, per_page: 10)
          instagrams = FeaturedVideo.filter_blacklist(blist).featured_block_desc.paginate(:page => page, per_page: 10)
      when "Recent"
          #binding.pry
          #instagrams = FeaturedVideo.filter_blacklist(blist).featured.has_video.instagram_desc.paginate(:page => page, per_page: 10)
          instagrams = FeaturedVideo.filter_blacklist(blist).recent_block_desc.paginate(:page => page, per_page: 10)
    end
    format_ins = []
    instagrams.each do |i|
      Thread.new{i.check_me(page)}
      #if i.check_me
      item = i.format_me
      #item.store("order_no",i.order_no)
      item.store("vs_stick", i.order_no>1?1:0) #Client Stick
      item.store("vs_page", page)
      format_ins << item
      #end
    end
    return format_ins
  end

  

  def recent #tag_recent_media
    page = params[:page].to_i
    # blist = BlackList.all.map{|b| b.username}
    # #instagrams = FeaturedVideo.filter_blacklist(blist).has_video.instagram_desc.paginate(:page => page, per_page: 10)
    # instagrams = FeaturedVideo.filter_blacklist(blist).instagram_desc.paginate(:page => page, per_page: 10)
    # # annotation test test22222
    # #binding.pry
    # format_ins = []
    # instagrams.each do |i|
    #   Thread.new{i.check_me}
    #   #if i.check_me
    #   item = i.format_me
    #   format_ins << item
    #   #end
    # end

    format_ins = queryCache('Recent',page,5)
    # request count++
    Thread.new{ReqCount.list_req_count(page,1,0,0)}

    render json: format_ins.to_json, :callback => params[:callback]
  end

  #get Instagram Tag Recent Data
  def getRecentData
    tag = params[:tag]
    maxId = params[:maxId]
    format_ins = []
    #binding.pry
    if tag == 'videoshowapp' or tag =='videoshow'
       Thread.new{FeaturedVideo.recentData(tag,maxId)}
       format_ins={:ret=>"running..."}
    else
       format_ins={:ret=>"tag error..."}
    end
    #Category.get_all_tags
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
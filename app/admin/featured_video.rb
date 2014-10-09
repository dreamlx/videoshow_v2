ActiveAdmin.register FeaturedVideo do
  
  sidebar :search do
    render 'search'
  end

  config.filters =false

  #actions :all, except: [:destroy,:edit, :new,:show]
  actions :all, except: [:destroy,:edit, :new]

  # batch_action :flag, form: {
  #   type: %w[Offensive Spam Other],
  #   reason: :text,
  #   notes:  :textarea,
  #   hide:   :checkbox,
  #   date:   :datepicker
  # } do |ids, inputs|
  #   binding.pry
  #   redirect_to action: 'index'
  # end

  batch_action :Recommend, confirm: "Are you sure you want to recommend these video?" do |ids|
    FeaturedVideo.find(ids).each do |item|
      item.recommend!
    end
    urlReferer=request.headers['HTTP_REFERER']
    if urlReferer!=nil && urlReferer.index('?')!=nil
       urlReferer=urlReferer[urlReferer.index('?')+1,urlReferer.length]
       paramsArr  = urlReferer.split("&")
       fvParams = {}
       paramsArr.each do |str|
          strArr = str.split("=") 
          fvParams.store(strArr[0],strArr[1])
       end
       redirect_to action: 'index', page:fvParams['page'],per_page:fvParams['per_page'],start_date:fvParams['start_date'],end_date:fvParams['end_date'],orderNo:fvParams['orderNo'],userName:fvParams['userName'],unpublish:fvParams['unpublish'],resolution:fvParams['resolution'],sortParam:fvParams['sortParam']
    else
       redirect_to action: 'index'
    end
    

    #fvParams = session[:fvParams] 
    #binding.pry
    #redirect_to action: 'index', page:fvParams['page'],per_page:fvParams['per_page'],start_date:fvParams['start_date'],end_date:fvParams['end_date'],orderNo:fvParams['orderNo'],userName:fvParams['userName'],unpublish:fvParams['unpublish'],resolution:fvParams['resolution'],sortParam:fvParams['sortParam']
    #redirect_to action: 'index', page:params[:page]||0,per_page:params[:per_page]||20,orderNo:params[:orderNo],userName:params[:userName],unpublish:params[:unpublish],resolution:params[:resolution]
    #redirect_to admin_featured_videos_path, alert: "Successfully recommended. "
  end

  batch_action :UnRecommend, confirm: "Are you sure you want to unrecommend these video?" do |ids|
    FeaturedVideo.find(ids).each do |item|
      item.uncommend!
    end
    urlReferer=request.headers['HTTP_REFERER']
    if urlReferer!=nil && urlReferer.index('?')!=nil
       urlReferer=urlReferer[urlReferer.index('?')+1,urlReferer.length]
       paramsArr  = urlReferer.split("&")
       fvParams = {}
       paramsArr.each do |str|
          strArr = str.split("=") 
          fvParams.store(strArr[0],strArr[1])
       end
       redirect_to action: 'index', page:fvParams['page'],per_page:fvParams['per_page'],start_date:fvParams['start_date'],end_date:fvParams['end_date'],orderNo:fvParams['orderNo'],userName:fvParams['userName'],unpublish:fvParams['unpublish'],resolution:fvParams['resolution'],sortParam:fvParams['sortParam']
    else
       redirect_to action: 'index'
    end
    #fvParams = session[:fvParams] 
    #redirect_to action: 'index', page:fvParams['page'],per_page:fvParams['per_page'],start_date:fvParams['start_date'],end_date:fvParams['end_date'],orderNo:fvParams['orderNo'],userName:fvParams['userName'],unpublish:fvParams['unpublish'],resolution:fvParams['resolution'],sortParam:fvParams['sortParam']
  end

  batch_action :Publish, confirm: "Are you sure you want to publish these video?" do |ids|
    FeaturedVideo.find(ids).each do |item|
      item.upBlock!
    end
    urlReferer=request.headers['HTTP_REFERER']
    if urlReferer!=nil && urlReferer.index('?')!=nil
       urlReferer=urlReferer[urlReferer.index('?')+1,urlReferer.length]
       paramsArr  = urlReferer.split("&")
       fvParams = {}
       paramsArr.each do |str|
          strArr = str.split("=") 
          fvParams.store(strArr[0],strArr[1])
       end
       redirect_to action: 'index', page:fvParams['page'],per_page:fvParams['per_page'],start_date:fvParams['start_date'],end_date:fvParams['end_date'],orderNo:fvParams['orderNo'],userName:fvParams['userName'],unpublish:fvParams['unpublish'],resolution:fvParams['resolution'],sortParam:fvParams['sortParam']
    else
       redirect_to action: 'index'
    end
    #fvParams = session[:fvParams] 
    #redirect_to action: 'index', page:fvParams['page'],per_page:fvParams['per_page'],start_date:fvParams['start_date'],end_date:fvParams['end_date'],orderNo:fvParams['orderNo'],userName:fvParams['userName'],unpublish:fvParams['unpublish'],resolution:fvParams['resolution'],sortParam:fvParams['sortParam']
   end

  batch_action :UnPublish, confirm: "Are you sure you want to unpublish these video?" do |ids|
    FeaturedVideo.find(ids).each do |item|
      item.upBlock!
    end
    urlReferer=request.headers['HTTP_REFERER']
    if urlReferer!=nil && urlReferer.index('?')!=nil
       urlReferer=urlReferer[urlReferer.index('?')+1,urlReferer.length]
       paramsArr  = urlReferer.split("&")
       fvParams = {}
       paramsArr.each do |str|
          strArr = str.split("=") 
          fvParams.store(strArr[0],strArr[1])
       end
       redirect_to action: 'index', page:fvParams['page'],per_page:fvParams['per_page'],start_date:fvParams['start_date'],end_date:fvParams['end_date'],orderNo:fvParams['orderNo'],userName:fvParams['userName'],unpublish:fvParams['unpublish'],resolution:fvParams['resolution'],sortParam:fvParams['sortParam']
    else
       redirect_to action: 'index'
    end
    #fvParams = session[:fvParams] 
    #redirect_to action: 'index', page:fvParams['page'],per_page:fvParams['per_page'],start_date:fvParams['start_date'],end_date:fvParams['end_date'],orderNo:fvParams['orderNo'],userName:fvParams['userName'],unpublish:fvParams['unpublish'],resolution:fvParams['resolution'],sortParam:fvParams['sortParam']
  end

  batch_action :Delete, confirm: "Are you sure you want to detete these video?" do |ids|
    FeaturedVideo.find(ids).each do |item|
      item.delete
    end
    urlReferer=request.headers['HTTP_REFERER']
    if urlReferer!=nil && urlReferer.index('?')!=nil
       urlReferer=urlReferer[urlReferer.index('?')+1,urlReferer.length]
       paramsArr  = urlReferer.split("&")
       fvParams = {}
       paramsArr.each do |str|
          strArr = str.split("=") 
          fvParams.store(strArr[0],strArr[1])
       end
       redirect_to action: 'index', page:fvParams['page'],per_page:fvParams['per_page'],start_date:fvParams['start_date'],end_date:fvParams['end_date'],orderNo:fvParams['orderNo'],userName:fvParams['userName'],unpublish:fvParams['unpublish'],resolution:fvParams['resolution'],sortParam:fvParams['sortParam']
    else
       redirect_to action: 'index'
    end
    #fvParams = session[:fvParams] 
    #redirect_to action: 'index', page:fvParams['page'],per_page:fvParams['per_page'],start_date:fvParams['start_date'],end_date:fvParams['end_date'],orderNo:fvParams['orderNo'],userName:fvParams['userName'],unpublish:fvParams['unpublish'],resolution:fvParams['resolution'],sortParam:fvParams['sortParam']
  end

  # batch_action :whitelist, :form => {:reason => :text} do |ids, reason|
  #   # do your stuff!
  #   binding.pry
  #   redirect_to admin_featured_videos_path, alert: "Successfully recommended. "
  # end

  # batch_action :doit, form: {user: [['Jake',2], ['Mary',3]]} do |ids, inputs|
  #   binding.pry
  #   item = FeaturedVideo.find(ids)
  #   binding.pry
  #   redirect_to admin_featured_videos_path, alert: "Successfully recommended. "
  # end

  # index as: :grid do |post|
  #   resource_selection_cell post
  #   h2 auto_link post
  # end

  # # Index as Blog requires nothing special

  # # Index as Block
  # index as: :block do |post|
  #   div for: post do
  #     resource_selection_cell post
  #   end
  # end

  index do
    selectable_column

    column  :username do |item|  
        link_to item.instagram_item["user"]["username"], item.instagram_item["link"],:target=>"_blank"
    end
    column :image do |item|
      image_tag item.instagram_item["images"]["thumbnail"]["url"],:size => '200x200'
    end

    column :video do |item|
      resolution = (!params[:resolution].blank?) ? params[:resolution].to_i : 0
      case resolution
       when 1 then
        videoUrlStr=item.instagram_item["videos"]["standard_resolution"]["url"]
        imgUrlStr=item.instagram_item["images"]["standard_resolution"]["url"]
        video_tag "http://videos-d-12.ak.instagram.com/hphotos-ak-xfa1"+videoUrlStr[videoUrlStr.rindex('/'),videoUrlStr.length-1],
          :controls => true,
          :autobuffer => true,
          :poster => "http://photos-b.ak.instagram.com/hphotos-ak-xpf1"+imgUrlStr[imgUrlStr.rindex('/'),imgUrlStr.length-1],
          :size => '640x640'
       when 2 then
        videoUrlStr=item.instagram_item["videos"]["low_resolution"]["url"]
        imgUrlStr=item.instagram_item["images"]["low_resolution"]["url"]
        video_tag "http://videos-d-12.ak.instagram.com/hphotos-ak-xfa1"+videoUrlStr[videoUrlStr.rindex('/'),videoUrlStr.length-1],
          :controls => true,
          :autobuffer => true,
          :poster => "http://photos-b.ak.instagram.com/hphotos-ak-xpf1"+imgUrlStr[imgUrlStr.rindex('/'),imgUrlStr.length-1],
          :size => '480x480'
      when 3 then
        videoUrlStr=item.instagram_item["videos"]["low_resolution"]["url"]
        imgUrlStr=item.instagram_item["images"]["thumbnail"]["url"]
        video_tag "http://videos-d-12.ak.instagram.com/hphotos-ak-xfa1"+videoUrlStr[videoUrlStr.rindex('/'),videoUrlStr.length-1],
          :controls => true,
          :autobuffer => true,
          :poster => "http://photos-b.ak.instagram.com/hphotos-ak-xpf1"+imgUrlStr[imgUrlStr.rindex('/'),imgUrlStr.length-1],
          :size => '300x300'
      when 4 then
        videoUrlStr=item.instagram_item["videos"]["low_resolution"]["url"]
        imgUrlStr=item.instagram_item["images"]["thumbnail"]["url"]
        video_tag "http://videos-d-12.ak.instagram.com/hphotos-ak-xfa1"+videoUrlStr[videoUrlStr.rindex('/'),videoUrlStr.length-1],
          :controls => true,
          :autobuffer => true,
          :poster => "http://photos-b.ak.instagram.com/hphotos-ak-xpf1"+imgUrlStr[imgUrlStr.rindex('/'),imgUrlStr.length-1],
          :size => '200x200'
      else
        video_tag item.instagram_item["videos"]["low_resolution"]["url"],
          :controls => true,
          :autobuffer => true,
          :poster => item.instagram_item["images"]["thumbnail"]["url"],
          :size => '200x200'
      end
    end

    column :link do |item|
      if item.block_status == false
        link_to item.instagram_item["link"],item.instagram_item["link"],:style=>"color:green;",:target=>"_blank"
      else
        link_to item.instagram_item["link"],item.instagram_item["link"],:style=>"color:red;",:target=>"_blank"
      end
    end
    column :likes_count do |item|
        item.instagram_item['likes']['count']
        #link_to item.instagram_item["user"]["username"], item.instagram_item["link"],:target=>"_blank"
    end
    column :created_time do |item|
      #Date.strptime(item.instagram_item["created_time"],'%Y-%m-%d')
      Time.at(item.instagram_item["created_time"].to_i).to_formatted_s(:db)
    end
    column :blacklist do |item|
      link_to "addBlack", {action: "addBlacks", id: item,userName:item.instagram_item["user"]["username"]}, :method => :put,:class => 'member_link view_link',:target=>"_blank"
    end

    column :recommend do |item|
      if item.order_no > 0
        #link_to('Cancel', uncommend_admin_featured_video_path(item), :method => :put,:class => 'button') 
        link_to "Cancel", {action: "uncommend", id: item, page:params[:page]||0,per_page:params[:per_page]||20,start_date:params[:start_date],end_date:params[:end_date],orderNo:params[:orderNo],userName:params[:userName],unpublish:params[:unpublish],resolution:params[:resolution],sortParam:params[:sortParam]}, :method => :put,:class => 'button'
      else
        #link_to('Recommend', recommend_admin_featured_video_path(item), :method => :put,:class => 'button')
        #link_to('Recommend', {:controller => "featured_videos", :action => "recommend", :param=value}, :method => :put,:class => 'button')
        link_to "Recommend", {action: "recommend", id: item, page:params[:page]||0,per_page:params[:per_page]||20,start_date:params[:start_date],end_date:params[:end_date],orderNo:params[:orderNo],userName:params[:userName],unpublish:params[:unpublish],resolution:params[:resolution],sortParam:params[:sortParam]}, :method => :put,:class => 'button'
      end
    end
    # column :stick do |item|
    #   item.order_no
    # end
    column :stick do |item|
      if item.order_no == 1
        #link_to('Stick', stick_admin_featured_video_path(item), :method => :put,:class => 'button') 
        link_to "Stick", {action: "stick", id: item, page:params[:page]||0,per_page:params[:per_page]||20,start_date:params[:start_date],end_date:params[:end_date],orderNo:params[:orderNo],userName:params[:userName],unpublish:params[:unpublish],resolution:params[:resolution],sortParam:params[:sortParam]}, :method => :put,:class => 'button'
      elsif item.order_no > 1
        #link_to('Unstick', unstick_admin_featured_video_path(item), :method => :put,:class => 'button')
        link_to "Unstick", {action: "unstick", id: item, page:params[:page]||0,per_page:params[:per_page]||20,start_date:params[:start_date],end_date:params[:end_date],orderNo:params[:orderNo],userName:params[:userName],unpublish:params[:unpublish],resolution:params[:resolution],sortParam:params[:sortParam]}, :method => :put,:class => 'button'
      end
    end
    column :Publish do |item|
        #link_to('View', views_admin_featured_video_path(item), :method => :put,:class=>"member_link view_link",:rel=>"nofollow") 
        #link_to('Delete', deletes_admin_featured_video_path(item), :method => :delete,:class=>"member_link delete_link",:confirm=>"Are you sure you want to delete this?",:rel=>"nofollow") 
      if item.block_status == false
        link_to "Unpublish", {action: "unpublish", id: item, page:params[:page]||0,per_page:params[:per_page]||20,start_date:params[:start_date],end_date:params[:end_date],orderNo:params[:orderNo],userName:params[:userName],unpublish:params[:unpublish],resolution:params[:resolution],sortParam:params[:sortParam]}, :method => :put,:class=>"member_link delete_link",:style=>"color:green;",:confirm=>"Are you sure you want to unpublish this?",:rel=>"nofollow"
      else
        link_to "Publish", {action: "publish", id: item, page:params[:page]||0,per_page:params[:per_page]||20,start_date:params[:start_date],end_date:params[:end_date],orderNo:params[:orderNo],userName:params[:userName],unpublish:params[:unpublish],resolution:params[:resolution],sortParam:params[:sortParam]}, :method => :put,:class=>"member_link delete_link",:style=>"color:red;",:rel=>"nofollow"
      end
    end

    column :Delete do |item|
      link_to "Delete", {action: "deletes", id: item, page:params[:page]||0,per_page:params[:per_page]||20,start_date:params[:start_date],end_date:params[:end_date],orderNo:params[:orderNo],userName:params[:userName],unpublish:params[:unpublish],resolution:params[:resolution],sortParam:params[:sortParam]}, :method => :delete,:class=>"member_link delete_link",:confirm=>"Are you sure you want to delete this?",:rel=>"nofollow"
    end
    
    column :action do |item|
       link_to 'View', admin_featured_video_path(item),:class=>"member_link view_link"
       #link_to('Delete', deletes_admin_featured_video_path(item), :method => :delete,:class=>"member_link delete_link",:confirm=>"Are you sure you want to delete this?",:rel=>"nofollow") 
    end
    #default_actions
  end


  controller do
    def index
      #binding.pry
      items = []
      # if !params[:orderNo].blank? && !params[:isDelete].blank?
      #    orderNo = params[:orderNo].to_i;
      #    if orderNo == 0
      #       items = FeaturedVideo.where(:"order_no"=> orderNo,:'instagram_item.user.username'=> params[:userName]).instagram_desc.page(params[:page]).per(params[:per_page]||20)
      #    else
      #       items = FeaturedVideo.where(:order_no=>{'$gte' => orderNo},:'instagram_item.user.username'=> params[:userName]).desc(:"order_no").desc(:"instagram_item.created_time").page(params[:page]).per(params[:per_page]||20)
      #    end
      # els
      # if !params[:orderNo].blank? && !params[:userName].blank?
      #    orderNo = params[:orderNo].to_i;
      #    if orderNo == 0
      #       items = FeaturedVideo.from_to_start(params[:start_date]).from_to_end(params[:end_date]).from_to_block(params[:unpublish]).where(:"order_no"=> orderNo,:'instagram_item.user.username'=> params[:userName]).instagram_desc.page(params[:page]).per(params[:per_page]||20)
      #    else
      #       items = FeaturedVideo.from_to_start(params[:start_date]).from_to_end(params[:end_date]).from_to_block(params[:unpublish]).where(:order_no=>{'$gte' => orderNo},:'instagram_item.user.username'=> params[:userName]).desc(:"order_no").instagram_desc.page(params[:page]).per(params[:per_page]||20)
      #    end
      # elsif !params[:orderNo].blank?
      #   orderNo = params[:orderNo].to_i;
      #   if orderNo == 0
      #     items = FeaturedVideo.from_to_start(params[:start_date]).from_to_end(params[:end_date]).from_to_block(params[:unpublish]).where(:"order_no"=> orderNo).instagram_desc.page(params[:page]).per(params[:per_page]||20)
      #   else
      #     items = FeaturedVideo.from_to_start(params[:start_date]).from_to_end(params[:end_date]).from_to_block(params[:unpublish]).where(:order_no=>{'$gte' => orderNo}).desc(:"order_no").instagram_desc.page(params[:page]).per(params[:per_page]||20)
      #   end
      # elsif !params[:userName].blank?
      #    items = FeaturedVideo.from_to_start(params[:start_date]).from_to_end(params[:end_date]).from_to_block(params[:unpublish]).where(:"instagram_item.user.username" => params[:userName]).instagram_desc.page(params[:page]).per(params[:per_page]||20)
      # else
      #    items = FeaturedVideo.from_to_start(params[:start_date]).from_to_end(params[:end_date]).from_to_block(params[:unpublish]).instagram_desc.page(params[:page]).per(params[:per_page]||20)
      # end
      
      blist = BlackList.all.map{|b| b.username}

      items = FeaturedVideo.from_to_start(params[:start_date]).from_to_end(params[:end_date]).from_to_block(params[:unpublish]).from_to_orderNo(params[:orderNo]).filter_blacklist(blist).from_to_userName(params[:userName]).instagram_param_desc(params[:sortParam]).page(params[:page]||1).per(params[:per_page]||20)
      if !params[:clearCache].blank? && params[:clearCache] =="1"
        ReqConfigCache.where(:"type".in => ["Featured","Recent"]).delete()
        #ReqConfigCache.where(:"type".in => ["Recent"]).delete()
      end
       
      # fvParams = {}
      # fvParams.store("page", params[:page]||1)
      # fvParams.store("per_page", params[:per_page]||20)
      # fvParams.store("orderNo", params[:orderNo])
      # fvParams.store("userName", params[:userName])
      # fvParams.store("unpublish", params[:unpublish])
      # fvParams.store("resolution", params[:resolution])
      # fvParams.store("start_date", params[:start_date])
      # fvParams.store("end_date", params[:end_date])
      # fvParams.store("sortParam", params[:sortParam])
      # session[:fvParams] = fvParams


      @featured_videos = items
      #
      #items = paginate_collection FeaturedVideo.find(:all,:conditions => ["order_no=?",params[:orderNo]||1]), :per_page => params[:per_page]||20, :page => params[:page]
      #SELECT "events".* FROM "events" INNER JOIN "categories" ON "categories"."id" = "events"."category_id"
      #items = FeaturedVideo.paginate :page => params[:page],:per_page => params[:per_page]||20,:conditions => ["userName like ?", "%#{params[:userName]}%"]
      #items = []
      #items=items.page(params[:page]).per(params[:per_page]||20)
      #if !params[:start_date].blank?
      #   items= items.from_to_start(params[:start_date])
      #end
      #if !params[:end_date].blank?
      #   items= items.from_to_end(params[:end_date])
      #end

      #items = FeaturedVideo.all
      #items = items.where(:'instagram_item.user.username'=> params[:userName]) unless params[:userName].blank?
      #items = items.where(:"order_no".nin => [0]) unless params[:orderNo].blank?
      #@featured_videos = items.page(params[:page]).per(params[:per_page]||20)

      #@featured_videos = items
    end
     
    # def delete
    #   #binding.pry
    #   item = FeaturedVideo.find(params[:id])
    #   item.delete
    #   ReqConfigCache.where(:"type".in => ["Featured","Recent"]).delete()
    #   redirect_to   action: 'index', page:params[:page]||0,per_page:params[:per_page]||20,orderNo:params[:orderNo],userName:params[:userName]
    # end

    def batch_action
      #binding.pry
      #if params[:batch_action] == "i_want_a_form"
      #  render "admin/users/batch_action", :layout => "active_admin"
      #else
        super
      #end
    end

  end


  member_action :recommend, :method => :put do
    #binding.pry
    item = FeaturedVideo.find(params[:id])
    item.recommend!
    #ReqConfigCache.where(:"type".in => ["Featured"]).delete()
    #redirect_to  admin_featured_videos_path
    #+"#featured_video_"
    redirect_to action: 'index', page:params[:page]||0,per_page:params[:per_page]||20,start_date:params[:start_date],end_date:params[:end_date],orderNo:params[:orderNo],userName:params[:userName],unpublish:params[:unpublish],resolution:params[:resolution],sortParam:params[:sortParam]
  end

  member_action :uncommend, :method => :put do
    item = FeaturedVideo.find(params[:id])
    item.uncommend!
    #ReqConfigCache.where(:"type".in => ["Featured"]).delete()
    redirect_to   action: 'index', page:params[:page]||0,per_page:params[:per_page]||20,start_date:params[:start_date],end_date:params[:end_date],orderNo:params[:orderNo],userName:params[:userName],unpublish:params[:unpublish],resolution:params[:resolution],sortParam:params[:sortParam]
  end

  member_action :stick, :method => :put do 
    #binding.pry
    item = FeaturedVideo.find(params[:id])
    itemMax = FeaturedVideo.featuredMaxOrderNo.first()
    orderNo = itemMax.order_no
    item.stick(orderNo)
    #ReqConfigCache.where(:"type".in => ["Featured"]).delete()
    redirect_to  action: 'index', page:params[:page]||0,per_page:params[:per_page]||20,start_date:params[:start_date],end_date:params[:end_date],orderNo:params[:orderNo],userName:params[:userName],unpublish:params[:unpublish],resolution:params[:resolution],sortParam:params[:sortParam]
  end

  member_action :unstick, :method => :put do 
    item = FeaturedVideo.find(params[:id])
    item.unstick!
    #ReqConfigCache.where(:"type".in => ["Featured"]).delete()
    redirect_to  action: 'index', page:params[:page]||0,per_page:params[:per_page]||20,start_date:params[:start_date],end_date:params[:end_date],orderNo:params[:orderNo],userName:params[:userName],unpublish:params[:unpublish],resolution:params[:resolution],sortParam:params[:sortParam]
  end

  member_action :deletes, :method => :delete do
    #binding.pry
    item = FeaturedVideo.find(params[:id])
    item.delete
    #ReqConfigCache.where(:"type".in => ["Featured","Recent"]).delete()
    redirect_to   action: 'index', page:params[:page]||0,per_page:params[:per_page]||20,start_date:params[:start_date],end_date:params[:end_date],orderNo:params[:orderNo],userName:params[:userName],unpublish:params[:unpublish],resolution:params[:resolution],sortParam:params[:sortParam]
  end

  member_action :unpublish, :method => :put do
    #binding.pry
    item = FeaturedVideo.find(params[:id])
    item.upBlock
    #ReqConfigCache.where(:"type".in => ["Featured","Recent"]).delete()
    redirect_to   action: 'index', page:params[:page]||0,per_page:params[:per_page]||20,start_date:params[:start_date],end_date:params[:end_date],orderNo:params[:orderNo],userName:params[:userName],unpublish:params[:unpublish],resolution:params[:resolution],sortParam:params[:sortParam]
  end

  member_action :publish, :method => :put do
    #binding.pry
    item = FeaturedVideo.find(params[:id])
    item.upBlock!
   # ReqConfigCache.where(:"type".in => ["Featured","Recent"]).delete()
    redirect_to   action: 'index', page:params[:page]||0,per_page:params[:per_page]||20,start_date:params[:start_date],end_date:params[:end_date],orderNo:params[:orderNo],userName:params[:userName],unpublish:params[:unpublish],resolution:params[:resolution],sortParam:params[:sortParam]
  end

  member_action :addBlacks, :method => :put do
    userName = params[:userName]
    if !userName.blank?
      blackList = BlackList.where(:'username' => userName).first
      if(blackList==nil)
        blackList = BlackList.new
        blackList.username=userName
        blackList.save
      end
      #redirect_to admin_black_lists_path, alert: "Already on the blacklist. "
      #redirect_to admin_black_lists_path, userName: userName, alert: "The blacklist added successfully. "
      redirect_to "/admin/black_lists?userName="+userName, notice: "The blacklist added successfully. "
      return
    end
    redirect_to admin_black_lists_path, alert: "Add failure blacklist. "
  end
  

end

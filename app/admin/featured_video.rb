ActiveAdmin.register FeaturedVideo do
  
  sidebar :search do
    render 'search'
  end

  config.filters =false

  #actions :all, except: [:destroy,:edit, :new,:show]
  actions :all, except: [:destroy,:edit, :new]

  index do
    #selectable_column

    column  :username do |item|
      link_to item.instagram_item["user"]["username"], item.instagram_item["link"]
    end
    column :image do |item|
      image_tag item.instagram_item["images"]["thumbnail"]["url"],:size => '128x128'
    end

    column :video do |item|
      video_tag item.instagram_item["videos"]["low_resolution"]["url"],
        :controls => true,
        :autobuffer => true,
        :poster => item.instagram_item["images"]["thumbnail"]["url"],
        :size => '200x200'
    end
    column :link do |item|
      item.instagram_item["link"]
    end
    column :created_time do |item|
      Date.strptime(item.instagram_item["created_time"],"%s")
    end

    column :recommend do |item|
      if item.order_no > 0
        link_to('Cancel', uncommend_admin_featured_video_path(item), :method => :put,:class => 'button') 
      else
        link_to('Recommend', recommend_admin_featured_video_path(item), :method => :put,:class => 'button')
      end
    end
    column :action do |item|
        #link_to('View', views_admin_featured_video_path(item), :method => :put,:class=>"member_link view_link",:rel=>"nofollow") 
        link_to('Delete', deletes_admin_featured_video_path(item), :method => :delete,:class=>"member_link delete_link",:confirm=>"Are you sure you want to delete this?",:rel=>"nofollow") 
    end
    #column :action2 do |item|
     #   link_to('View', admin_featured_video_path(item),:class=>"member_link view_link") 
        #link_to('Delete', deletes_admin_featured_video_path(item), :method => :delete,:class=>"member_link delete_link",:confirm=>"Are you sure you want to delete this?",:rel=>"nofollow") 
    #end
    default_actions
  end


  controller do
    def index
      #binding.pry
      items = []
      if !params[:orderNo].blank? && !params[:userName].blank?
         items = FeaturedVideo.where(:"order_no" => params[:orderNo].to_i,:'instagram_item.user.username'=> params[:userName]).page(params[:page]).per(params[:per_page]||20)
      elsif !params[:orderNo].blank?
         items = FeaturedVideo.where(:"order_no" => params[:orderNo].to_i).page(params[:page]).per(params[:per_page]||20)
      elsif !params[:userName].blank?
         items = FeaturedVideo.where(:"instagram_item.user.username" => params[:userName]).page(params[:page]).per(params[:per_page]||20)
      else
         items = FeaturedVideo.page(params[:page]).per(params[:per_page]||20)
      end

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

  end


  member_action :recommend, :method => :put do
    item = FeaturedVideo.find(params[:id])
    item.recommend!
    ReqConfigCache.where(:"type".in => ["Featured"]).delete()
    redirect_to  admin_featured_videos_path
  end

  member_action :uncommend, :method => :put do
    item = FeaturedVideo.find(params[:id])
    item.uncommend!
    ReqConfigCache.where(:"type".in => ["Featured"]).delete()
    redirect_to  admin_featured_videos_path
  end

  member_action :deletes, :method => :delete do
    #binding.pry
    item = FeaturedVideo.find(params[:id])
    item.delete
    ReqConfigCache.where(:"type".in => ["Featured","Recent"]).delete()
    redirect_to  admin_featured_videos_path
  end
  

end

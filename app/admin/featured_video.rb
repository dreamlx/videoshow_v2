ActiveAdmin.register FeaturedVideo do
  config.filters =false
  actions :all, except: [:edit, :new] 

  index do
    column :order_no
    column  :username do |item|
      item.instagram_item["user"]["username"]
    end
    column :image do |item|
      image_tag item.instagram_item["images"]["thumbnail"]["url"],:size => '128x128'
    end
    column :video do |item|
      video_tag item.instagram_item["videos"]["low_resolution"]["url"],
        :controls => true,
        :autobuffer => true,
        :poster => item.instagram_item["images"]["low_resolution"]["url"],
        :size => '200x200'
    end
    column :link do |item|
      item.instagram_item["link"]
    end
    column :tags do |item|
      item.instagram_item["tags"]
    end
    column :created_time do |item|
      Date.strptime(item.instagram_item["created_time"],"%s")
    end

    column :recommend do |item|
      if item.order_no > 0
        button_to('uncommend', uncommend_admin_featured_video_path(item), :method => :put) 
      else
        button_to('Recommend', recommend_admin_featured_video_path(item), :method => :put)
      end
    end
    default_actions
  end

  member_action :recommend, :method => :put do
    item = FeaturedVideo.find(params[:id])
    item.gotop!
    redirect_to  admin_featured_videos_path
  end

  member_action :uncommend, :method => :put do
    item = FeaturedVideo.find(params[:id])
    item.uncommend!
    redirect_to  admin_featured_videos_path
  end  

  action_item :only => :show  do
    link_to('Recommend', recommend_admin_featured_video_path(featured_video), :method => :put)
  end

  action_item :only => :show  do
    link_to('uncommend', uncommend_admin_featured_video_path(featured_video), :method => :put)
  end
end

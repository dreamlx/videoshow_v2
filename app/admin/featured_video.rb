ActiveAdmin.register FeaturedVideo do
  config.filters =false

  actions :all, except: [:edit, :new]

  index do
    selectable_column

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
    default_actions
  end

  member_action :recommend, :method => :put do
    item = FeaturedVideo.find(params[:id])
    item.recommend!
    redirect_to  admin_featured_videos_path
  end

  member_action :uncommend, :method => :put do
    item = FeaturedVideo.find(params[:id])
    item.uncommend!
    redirect_to  admin_featured_videos_path
  end
end

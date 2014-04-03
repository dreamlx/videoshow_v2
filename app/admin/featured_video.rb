ActiveAdmin.register FeaturedVideo do

  index do
    column :order_no
    column  :username do |item|
      item.instagram_item["user"]["username"]
    end
    column :image do |item|
      image_tag item.instagram_item["images"]["thumbnail"]["url"]
    end
    column :video do |item|
      video_tag item.instagram_item["videos"]["low_resolution"]["url"],
        :controls => true,
        :autobuffer => true,
        :poster => item.instagram_item["images"]["low_resolution"]["url"]
    end
    column :tags do |item|
      item.instagram_item["tags"]
    end
    column :created_time do |item|
      Date.strptime(item.instagram_item["created_time"],"%s")
    end
    default_actions
  end

  member_action :set_top, :method => :put do
    item = FeaturedVideo.find(params[:id])
    item.gotop!
    redirect_to  admin_featured_video_path(item)
  end

  action_item :only => :show  do
    link_to('Go Top', set_top_admin_featured_video_path(featured_video), :method => :put)
  end

end

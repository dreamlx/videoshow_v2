ActiveAdmin.register FeaturedVideo do     
  index do                            
    column :order_no
    column  :username do |item|
      item.instagram_item["user"]["username"]
    end
    column :profile_img do |item|
      image_tag item.instagram_item["user"]["profile_picture"]
    end
    column :imges do |item|
      image_tag item.instagram_item["images"]["low_resolution"]["url"]
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

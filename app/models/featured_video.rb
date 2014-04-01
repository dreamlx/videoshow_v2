class FeaturedVideo
  # attr_accessible :title, :body
  include Mongoid::Document
  field :instagram_item, :type => Hash
  field :order_no, :type => Integer, default: 0
  field :block_status, :type => Boolean, default: false

  default_scope desc(:"order_no, instagram_item.created_time")
  scope :has_video, where(:"instagram_item.videos".nin => [nil, ""])
  scope :instagram_desc, desc(:"instagram_item.created_time")
  scope :instagram_asc, asc(:"instagram_item.created_time")

  def self.filter_blacklist(blacklist)
    where(:"instagram_item.user.username".nin => blacklist)
  end

  def gotop!
    self.order_no = FeaturedVideo.first.order_no + 1
    self.save
  end

  def self.update_last(count)
    self.all.limit(count).each do |item|
      item.instagram_item  = Instagram.media_item(item.instagram_item["id"])
      item.save
    end
  end

  def self.tag_recent_media(tag='videoshow',count=300)
    instagrams = self.new
    FeaturedVideo.retryable(:tries => 10, :on => Timeout::Error) do
      timeout(15) do
        instagram_collection = Instagram.tag_recent_media(tag, { count: count })
        instagram_collection.each do |item|
          if item.type == 'video'
            if FeaturedVideo.where(:'instagram_item.id' => item.id).count == 0
              self.create!(instagram_item: item)
            else
              FeaturedVideo.where(:'instagram_item.id' => item.id).update(instagram_item: item)
            end
          end
        end
      end
    end
    return instagrams
  end

  def self.retryable(options = {})
    opts = { :tries => 1, :on => Exception }.merge(options)

    retry_exception, retries = opts[:on], opts[:tries]

    begin
      return yield
    rescue retry_exception
      if (retries -= 1) > 0
        sleep 2
        retry
      else
        logger.info 'TimeOut:get tag_recent_media'
      end
    end
  end
end

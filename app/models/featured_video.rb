class FeaturedVideo
  # attr_accessible :title, :body
  include Mongoid::Document
  field :instagram_item, :type => Hash
  field :order_no, :type => Integer, default: 0
  field :block_status, :type => Boolean, default: false

  default_scope desc(:"instagram_item.created_time")
  scope :has_video, where(:"instagram_item.videos".nin => [nil, ""])
  scope :instagram_desc, desc(:"instagram_item.created_time")
  scope :instagram_asc, asc(:"instagram_item.created_time")
  scope :featured, where(:"order_no".nin => [nil, "", 0]).desc(:"order_no")

  def self.filter_blacklist(blacklist)
    where(:"instagram_item.user.username".nin => blacklist)
  end

  def uncommend!
    self.order_no = 0
    self.save
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

  def self.clear_bad_item
    self.all.limit(300).each do |item|
      request = Typhoeus.get(item.instagram_item['images']['thumbnail']['url'])
      if request.code == 0
        item.delete
      else
        if Typhoeus.get(item.instagram_item['user']['profile_picture']).code == 0
          item.instagram_item  = Instagram.media_item(item.instagram_item["id"])
          item.save
        end
      end
    end
  end
end

class FeaturedVideo
  # attr_accessible :title, :body
  include Mongoid::Document
  field :instagram_item, :type => Hash

  def self.tag_recent_media(tag='videoshow',count=300)
    instagrams = self.new
    FeaturedVideo.retryable(:tries => 10, :on => Timeout::Error) do
      timeout(15) do
        instagram_collection = Instagram.tag_recent_media(tag, { count: count })
        instagram_collection.each do |item|
          self.create!(instagram_item: item) if item.type == 'video' and FeaturedVideo.where(:'instagram_item.id' => item.id).count == 0
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

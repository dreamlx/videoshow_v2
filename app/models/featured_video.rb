class FeaturedVideo
  # attr_accessible :title, :body
  include Mongoid::Document
  field :instagram_collection, :type => Hash

  def self.tag_recent_media(tag='videoshow',count=30)
    instagrams = self.new
    FeaturedVideo.retryable(:tries => 10, :on => Timeout::Error) do
      timeout(15) do
        instagrams.instagram_collection = Instagram.tag_recent_media(tag, { count: count })
        instagrams.save
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

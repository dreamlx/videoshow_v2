class FeaturedVideo
  # attr_accessible :title, :body
  include Mongoid::Document
  field :instagram_collection, :type => Hash
  field :instagram_item, :type => Hash

  def self.tag_recent_media(tag='videoshow',count=30)
    instagrams = self.new
    FeaturedVideo.retryable(:tries => 10, :on => Timeout::Error) do
      timeout(15) do
        instagram_collection = Instagram.tag_recent_media(tag, { count: count })
        instagram_collection.map{ |i| i unless i.videos.blank? }
        instagram_collection.compact.each { |item| self.create!(instagram_item: item)}
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

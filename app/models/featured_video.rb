class FeaturedVideo < ActiveRecord::Base
  # attr_accessible :title, :body
  def self.tag_recent_media(tag,count)
    instagrams = []
    FeaturedVideo.retryable(:tries => 10, :on => Timeout::Error) do
      timeout(15){ tag_recent_media(tag, { count: count }) }
    end
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
        logger.info 'TimeOut:get tag_search'
      end
    end
  end
end

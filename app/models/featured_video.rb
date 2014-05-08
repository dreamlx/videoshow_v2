class FeaturedVideo
  # attr_accessible :title, :body
  include Mongoid::Document
  field :instagram_item, :type => Hash
  field :order_no, :type => Integer, default: 0
  field :block_status, :type => Boolean, default: false
  field :update_date, :type => DateTime

  default_scope desc(:"instagram_item.created_time").where(:"instagram_item.videos".nin => [nil, ""])
  scope :has_video, where(:"instagram_item.videos".nin => [nil, ""])
  scope :instagram_desc, desc(:"instagram_item.created_time")
  scope :instagram_asc, asc(:"instagram_item.created_time")
  scope :featured, where(:"order_no".nin => [nil, "", 0]).desc(:"order_no")

  def format_me
      item = self.instagram_item
      item.delete 'attribution'
      item.delete 'tags'
      item.delete 'location'
      item.delete 'comments'
      item['likes'].delete 'data'
      item.delete 'caption'

      return item
  end

  def self.filter_blacklist(blist)
    where(:"instagram_item.user.username".nin => blist)
  end

  def uncommend!
    self.order_no = 0
    self.save
  end

  def recommend!
    self.order_no = self.order_no + 1
    self.save
  end

  def self.recent(tag='videoshow')
    #todo: min:before, max:after
    instagrams = self.new
    FeaturedVideo.retryable(:tries => 3, :on => Timeout::Error) do
      timeout(7) do
        instagram_collection = Instagram.tag_recent_media(tag)
        instagram_collection.reject { |i| i.type != 'video' }.each do |item|
          if FeaturedVideo.where(:'instagram_item.id' => item.id).count == 0
            self.create!(instagram_item: item, update_date: Time.now)
          else
            items = FeaturedVideo.where(:'instagram_item.id' => item.id).each do |item|
              item.check_me
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

  def check_me
      if self.update_date.nil?
        self.update_date = DateTime.now
        self.save
      end
      
      if self.update_date > 5.minutes.ago
        self.update_date = DateTime.now
        self.save

        request3 = Typhoeus.get("https://api.instagram.com/v1/media/#{self.instagram_item['id']}?client_id=80d957c56456440fa205a651372bbcb3")
        
        if request3.code == 400
          self.delete
          return false
        else
          request = Typhoeus.get(self.instagram_item['images']['thumbnail']['url'])
          if request.code == 400
            self.delete
            return false
          end
          request2 = Typhoeus.get(self.instagram_item['user']['profile_picture'])
          self.update_item if request2.code == 0
          return true
        end
      else
        return true
      end

  end

  def update_item
      self.instagram_item  = Instagram.media_item(self.instagram_item["id"])
      self.save
  end

  def self.update_all(skipnum = 30, limitnum=100)
    self.limit(limitnum).skip(skipnum).each do |item|
      item.instagram_item  = Instagram.media_item(item.instagram_item["id"])
      item.save
    end
  end
end

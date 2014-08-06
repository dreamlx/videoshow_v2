class FeaturedVideo
  # attr_accessible :title, :body
  include Mongoid::Document
  field :instagram_item, :type => Hash
  field :order_no, :type => Integer, default: 0
  field :block_status, :type => Boolean, default: false
  field :update_date, :type => DateTime
  #field :created_time, :type => String

  #default_scope desc(:"instagram_item.created_time").where(:"instagram_item.videos".nin => [nil, ""])
  #default_scope desc(:"instagram_item.created_time")
  scope :has_video, where(:"instagram_item.videos".nin => [nil, ""])
  scope :instagram_desc, desc(:"instagram_item.created_time")
  scope :recent_block_desc, where(:"block_status" => false).desc(:"instagram_item.created_time")
  scope :instagram_asc, asc(:"instagram_item.created_time")
  scope :featured, where(:"order_no".nin => [nil, "", 0]).desc(:"order_no")
  scope :featured_block_desc, where(:"order_no".ne => 0,:"block_status" => false).desc(:"order_no").desc(:"instagram_item.created_time")
  scope :featuredMaxOrderNo, where(:"order_no".nin => [0]).desc(:"order_no").limit(1)
  scope :instagram_param_desc, ->(sortParam='created_time') {
          #binding.pry
          if sortParam=='created_time'
            desc(:"instagram_item.created_time")
          elsif sortParam=='recommend'
            desc(:"order_no")
          elsif sortParam=='likes_count'
            desc(:"instagram_item.likes.count")
          else
            desc(:"instagram_item.created_time")
          end
        }
  scope :from_to_block, ->(unpublish=nil) {
          #binding.pry
          if !unpublish.blank?
            where(:"block_status" =>unpublish)
          end
        }
  scope :from_to_userName, ->(userName=nil) {
          if !userName.blank?
            where(:"instagram_item.user.username" =>userName)
          end
        }
  scope :from_to_orderNo, ->(orderNo=nil) {
          if !orderNo.blank?
            if orderNo == 0
              where(:"order_no" => orderNo)
            else
              where(:order_no=>{'$gte' => orderNo})
            end
          end
        }
  scope :from_to_start, ->(start_date=nil) {
          if !start_date.blank?
            #Date.strptime("2017-09-10")
            #Date.strptime("{2017-09-10}", "{ %Y %m %d }")
            #Date.strptime("2017-09-10", "{%s}")
            #1406369807  1406369734 1406369713
            #t = Date.strptime("1406369713","%Y-%m-%d").to_time
            #t = Date.strptime("1406369713").to_time
            #Time.at(1406498272).to_formatted_s(:db) 
            #where(instagram_item.created_time:  {'$gte' => start_date})
            t = start_date.to_time.to_i.to_s
            #binding.pry
            where(:"instagram_item.created_time" =>   {'$gte' => t})
            #where(created_time: {'$gte' => t})
          end
        }
  scope :from_to_end, ->(end_date=nil) {
          if !end_date.blank?
            t = (end_date+" 23:59:59").to_time.to_i.to_s
            where(:"instagram_item.created_time" =>   {'$lte' => t})
            #where(created_time: {'$lte' => t})
          end
        }
  scope :instagram_likes_count_desc, desc(:"instagram_item.likes.count").limit(10)
  scope :instagram_likes_count_gte, ->(count) {
          where(:"instagram_item.likes.count" =>   {'$gte' => count})
        }    

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
    #self.order_no = self.order_no + 1
    self.order_no = 1
    self.save
  end

  # set up
  def stick(orderNo=0)
    self.order_no = orderNo + 1
    self.save
  end

  def unstick!
    self.order_no = 1
    self.save
  end

  def upBlock
    self.block_status = true
    self.save
  end

  def upBlock!
    self.block_status = false
    self.save
  end

  def self.retryable(options = {})
    #binding.pry
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

  def self.recent_(tag='videoshow',minId="",maxId="")
    options={}
    if !minId.blank?
      options["min_id"]=minId
    end
    if !maxId.blank?
      options["max_id"]=maxId
    end 
    #binding.pry
    instagram_collection = {}
    FeaturedVideo.retryable(:tries => 0, :on => Timeout::Error) do
      timeout(22) do
         instagram_collection = Instagram.tag_recent_media(tag,options)
      end
    end
    return instagram_collection
  end

  def self.recent(tag='videoshow',minId="")
    #todo: min:before, max:after
    #instagrams = self.new
    #binding.pry
    begin
      instagram_collection = recent_(tag,minId,"")
      if instagram_collection.size>0 
        instagram_collection.reject { |i| i.type != 'video' }.each do |item|
          if FeaturedVideo.where(:'instagram_item.id' => item.id).count == 0
            self.create!(instagram_item: item, update_date: Time.now, order_no:0, block_status:false)
            Thread.new{ReqCount.list_req_count(1,0,0,1)}
          else
            item2 = FeaturedVideo.where(:'instagram_item.id' => item.id).first
            item2.instagram_item = item
            item2.save
          end
        end
        if instagram_collection.pagination.next_min_id !=nil
           minId = instagram_collection.pagination.next_min_id
           minId = self.recent(tag,minId)
           #return minId
        end
      end
    rescue
        logger.info "[ERROR][recent1]["+tag+"]["+maxId+"]=============================== :#{$!} at:#{$@}"
    end
    return minId
  end


  def self.recentData(tag='videoshow',maxId="")
    #todo: min:before, max:after
    begin
      instagram_collection = recent_(tag,"",maxId)
      #binding.pry
      if instagram_collection.size>0 
        instagram_collection.reject { |i| i.type != 'video' }.each do |item|
          if FeaturedVideo.where(:'instagram_item.id' => item.id).count == 0
            self.create!(instagram_item: item, update_date: Time.now, order_no:0, block_status:false)
            #,created_time:item.created_time
          else
            # item2 = FeaturedVideo.where(:'instagram_item.id' => item.id).first
            # item2.instagram_item = item
            # item2.save
          end
        end
        options={}
        if instagram_collection.pagination.next_max_id !=nil
           maxId = instagram_collection.pagination.next_max_id
           self.recentData(tag,maxId)
        end
      else
        instagram_collection.pagination["options"]=options
        logger.info "[END][recentData]" + (instagram_collection.to_s)
      end
    rescue
        #binding.pry
        logger.info "[ERROR][recentData]["+tag+"]["+maxId+"]=============================== :#{$!} at:#{$@}"
        #self.recentData(tag,maxId)
    end
  end





  def check_me(page=1)
    begin
      #flag = true
      #request2 = Typhoeus.get(self.instagram_item['user']['profile_picture'])
      #if request2.code == 0 or request2.code == 400
      #  self.update_item
      #  flag = true
      #end#
      #binding.pry
      if self.update_date < 6.minutes.ago
        #self.update_date = DateTime.now
        #self.save
        request3 = Typhoeus.get(self.instagram_item['link'])
        if request3.code == 404 or request3.code == 400 #or request3.code ==0
          self.delete
          if(self.order_no>0)
              #self.update_date = DateTime.now
              #self.update_item
              ReqConfigCache.where(:"type".in => ["Featured", "Recent"]).delete()
          else
              #self.upBlock
              ReqConfigCache.where(:"type".in => ["Recent"]).delete()
          end
          #flag = false
          
        else
          self.update_date = DateTime.now
          self.update_item
          #flag = true
        end
      end
    rescue
        logger.info "[ERROR][check_me]=============================== :#{$!} at:#{$@}"
    end
    #return flag
  end

  def update_item
      begin
         #binding.pry
         self.instagram_item  = Instagram.media_item(self.instagram_item["id"])
         #self.instagram_item  = Instagram.media_item('701259366418567032_332914818')
      rescue #=> err
         logger.info "[ERROR][update_item]============================== :#{$!} at:#{$@}"
      end
      self.save
  end

  def self.update_all(skipnum = 30, limitnum=100)
    self.limit(limitnum).skip(skipnum).each do |item|
      item.instagram_item  = Instagram.media_item(item.instagram_item["id"])
      item.save
    end
  end

  def self.up_all_create_time
    FeaturedVideo.all.each do |item|
      #item.created_time=instagram_item.created_time
      #item.save
    end
  end

  def self.auto_likes
    time = Time.new-1.days
    day = time.strftime("%Y-%m-%d")
    instagrams = []
    #binding.pry
    instagrams = FeaturedVideo.from_to_start(day).from_to_end(day).instagram_likes_count_gte(0).instagram_likes_count_desc#.page(1).per(10)
    instagrams.all.each do |item|
        item.recommend!
    end
  end
  
  
end

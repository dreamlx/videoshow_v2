class ReqCount
  include Mongoid::Document
  field :req_day, type: String, default: ''
  field :recent_num, type: Integer, default: 0
  field :featured_num, type: Integer, default: 0
  field :share_num, type: Integer, default: 0
  #index :ssn, unique: true
  #index :req_day

  default_scope desc(:"req_day")
  scope :from_to, ->(start_date, end_date) {
          where(req_day:  {'$gte' => start_date, '$lte' => end_date})
        }
  scope :from_to_start, ->(start_date) {
          where(req_day:  {'$gte' => start_date})
        }
  scope :from_to_end, ->(end_date) {
          where(req_day:  {'$lte' => end_date})
        }


  # ReqCount type:1.'recent' 2.featured
  def self.list_req_count(page = 1, recentNum=0,featuredNum=0,shareNum=0) 
    #i1=Time.new.to_i
    #Rails.logger.debug("event: #{@event.inspect}")
    #Rails.logger.debug("========================"+(Time.new.to_i))
    if page == 1
       #binding.pry
       time = Time.new + 8.hours #Beijing time
       day = time.strftime("%Y-%m-%d")
       reqCount = self.where(:'req_day' => day).first
       if(reqCount==nil)
       	  begin
       	  	@mutex=Mutex.new
       	  	@mutex.lock
       	  	   if self.where(:'req_day' => day).count == 0
       	  	     self.create!(req_day: day, recent_num: recentNum,featured_num:featuredNum,share_num:shareNum)
       	  	   end
       	  	@mutex.unlock 
       	  rescue
       	  	$! #表示异常信息
            $@ #表示异常出现的代码位置
            puts "error:#{$!} at:#{$@}"
          ensure
            #不管有没有异常，进入该代码块
          end
       else
          #reqCount = self.where(:'req_day' => day).first
          reqCount.recent_num = reqCount.recent_num+recentNum
          reqCount.featured_num = reqCount.featured_num+featuredNum
          reqCount.share_num = reqCount.share_num+shareNum
          reqCount.save
       end
    end
    #i2=Time.new.to_i
    #i3 = i2-i1
    #binding.pry
  end


end

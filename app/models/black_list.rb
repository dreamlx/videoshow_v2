class BlackList
  include Mongoid::Document
  field :username, type: String

  scope :from_to_userName, ->(userName=nil) {
          if !userName.blank?
          	#binding.pry
            where(:"username" =>userName)
          end
        }


  def self.getMapAll()
  	 blist = BlackList.all.map{|b| b.username}
  	 return blist
  end

end

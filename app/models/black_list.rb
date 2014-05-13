class BlackList
  include Mongoid::Document
  field :username, type: String


  def self.getMapAll()
  	 blist = BlackList.all.map{|b| b.username}
  	 return blist
  end

end

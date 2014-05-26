class HomeTopAdvert
  include Mongoid::Document
  field :type, type: Integer
  field :name, type: String
  field :pic_url, type: String
  field :advert_activity, type: String
  field :advert_url, type: String
  field :advert_content, type: String
  field :sort, type: Integer,default:0
  field :status, type: Integer,default:1
  field :ctime, type: DateTime
  field :etime, type: DateTime


  def format_me
      item = self
      item['sort'].delete 
      item['status'].delete 
      item['ctime'].delete 
      item['etime'].delete 
      return item
  end

  
end


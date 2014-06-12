class Category
  include Mongoid::Document
  field :title, type: String
  field :related_tag, type: String
  field :min_id, type: String
  field :max_id, type: String

  def self.get_all_tags
    Category.all.each do |c|
      minId = FeaturedVideo.recent(c.related_tag,c.min_id)
      #binding.pry
      if !minId.blank? && minId!=c.min_id
         c.min_id = minId
         c.save
      end
    end
  end
end

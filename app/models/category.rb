class Category
  include Mongoid::Document
  field :title, type: String
  field :related_tag, type: String

  def self.get_all_tags
    Category.all.each do |c|
      FeaturedVideo.tag_recent_media(c.related_tag)
    end
  end
end

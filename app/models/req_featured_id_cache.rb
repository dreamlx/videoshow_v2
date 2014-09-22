class ReqFeaturedIdCache
  include Mongoid::Document
  field :featured_video_id, type: String
end

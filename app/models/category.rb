class Category
  include Mongoid::Document
  field :title, type: String
  field :related_tag, type: String
end

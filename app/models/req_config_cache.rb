class ReqConfigCache
  include Mongoid::Document
  field :config_id, type: String
  field :type, type: String
  field :page, type: Integer
  field :content, type: Hash
  field :update_time, type: DateTime
end

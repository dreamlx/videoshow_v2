class ClientLog
  include Mongoid::Document
  include Mongoid::Timestamps
  mount_uploader :client_log, ClientLogUploader
  attr_accessible :client_log, :client_log_cache
  default_scope desc(:"created_at")
end
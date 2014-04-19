class ClientLog
  include Mongoid::Document
  include Mongoid::Timestamps
  field :check_status, type: Boolean
  field :os_version, type: String
  field :phone_model, type: String
  field :app_version, type: String
  mount_uploader :client_log, ClientLogUploader
  attr_accessible :client_log, :client_log_cache
  default_scope desc(:"created_at")

  scope :from_to, ->(start_date, end_date) {
          where(created_at:  {'$gt' => start_date, '$lt' => end_date})
        }

  def check!
    self.check_status = true
    self.save
  end

  def cancel!
    self.check_status = false
    self.save
  end
end
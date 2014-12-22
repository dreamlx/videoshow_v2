class ClientLogSwitch
  include Mongoid::Document
  include Mongoid::Timestamps
  field :upload_status, type: Boolean

  def check!
    self.upload_status = true
    self.save
  end

  def cancel!
    self.upload_status = false
    self.save
  end
end
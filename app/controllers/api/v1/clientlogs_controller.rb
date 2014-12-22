class Api::V1::ClientlogsController < Api::BaseController
  def create
    clientLogSwitch = ClientLogSwitch.first
    #binding.pry
    upload_status = true

    if(clientLogSwitch == nil )
        clientLogSwitch = ClientLogSwitch.create!(upload_status:true)
    else
        upload_status = clientLogSwitch.upload_status
    end


    if(upload_status == true) 
      u = ClientLog.new
      u.client_log = params[:logfile]
      u.os_version = params[:os_version]
      u.phone_model= params[:phone_model]
      u.app_version= params[:app_version]
      if u.save!
        render json: u.to_json
      else
        render json: "error"
      end
    else
        render json: "upload close"
    end

  end

  def index
    render json: ClientLog.limit(1).to_json
  end
end
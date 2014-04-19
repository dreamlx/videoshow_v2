class Api::V1::ClientlogsController < Api::BaseController
  def create
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
  end

  def index
    render json: 'test'
  end
end
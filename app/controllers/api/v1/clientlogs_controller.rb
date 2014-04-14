class Api::V1::ClientlogsController < Api::BaseController
  def create
    u = ClientLog.new
    u.client_log = params[:logfile]
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
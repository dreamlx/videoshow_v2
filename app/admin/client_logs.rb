ActiveAdmin.register ClientLog do
  sidebar :search do
    render 'search'
  end

  config.filters =false

  

  index do
    selectable_column

    upload_status = (ClientLogSwitch.first).upload_status

    column :os_version
    column :app_version
    column :phone_model
    column :created_at
    column :logfile do |c|
      link_to c.client_log, c.client_log.url
    end
    column :fileSize do |item|
       urlStr=Pathname.new(__FILE__).realpath.to_s
       #item.client_log.to_s
       urlStr=urlStr[0,urlStr.rindex('/videoshow_v2/')+14]+'public'+item.client_log.to_s
       f=File.size(urlStr).to_f/1024;
       (format("%.2f",f).to_f).to_s+"KB"
       #Dir.pwd item.client_log
    end

    column :check_status do |item|
      if item.check_status
        link_to('cancel', cancel_admin_client_log_path(item), :method => :put,:class => 'button') 
      else
        link_to('check', check_admin_client_log_path(item), :method => :put,:class => 'button')
      end
    end

    column :upload_status do |item|
      if upload_status
        link_to('upload_cancel', uploadcancel_admin_client_log_path(item), :method => :put,:class => 'button') 
      else
        link_to('upload_check', uploadcheck_admin_client_log_path(item), :method => :put,:class => 'button')
      end
    end
  end

  controller do
    def index
      #binding.pry
      upload_status = (ClientLogSwitch.first).upload_status

      items = ClientLog.all
      if params[:start_date].blank? or params[:end_date].blank?
        # skip
      else
        items= items.from_to(params[:start_date], params[:end_date])
      end

      items = items.where(phone_model: params[:phone_model]) unless params[:phone_model].blank?
      items = items.where(app_version: params[:app_version]) unless params[:app_version].blank?
      items = items.where(os_version: params[:os_version]) unless params[:os_version].blank?

      @client_logs = items.page(params[:page]).per(params[:per_page]||20)
    end

    # def new
    #   #render :file => 'admin/home_top_adverts/newUpload.rhtml'
    #   #render :file => 'admin/home_top_adverts/new.html.erb'
    #   #binding.pry
    #   #@home_top_advert = HomeTopAdvert.new
    #   #respond_to do |format|
    #     #format.html # new.html.erb
    #   #  format.html { render '/admin/home_top_adverts/new.html.erb'}
    #   #  format.json { render :json => @home_top_advert }
    #   #end
    #   super
    # end
  end
  member_action :cancel, :method => :put do
    item = ClientLog.find(params[:id])
    item.cancel!
    redirect_to  admin_client_logs_path
  end

  member_action :check, :method => :put do
    item = ClientLog.find(params[:id])
    item.check!
    redirect_to  admin_client_logs_path
  end  


  member_action :uploadcancel, :method => :put do
    clientLogSwitch = ClientLogSwitch.first
    clientLogSwitch.cancel!
    redirect_to  admin_client_logs_path
  end

  member_action :uploadcheck, :method => :put do
    clientLogSwitch = ClientLogSwitch.first
    clientLogSwitch.check!
    redirect_to  admin_client_logs_path
  end  
end

ActiveAdmin.register ClientLog do
  sidebar :search do
    render 'search'
  end

  config.filters =false

  index do
    selectable_column
    
    column :id 
    column :created_at
    column :logfile do |c|
      link_to c.client_log, c.client_log.url
    end
    column :check_status do |item|
      if item.check_status 
        link_to('cancel', cancel_admin_client_log_path(item), :method => :put,:class => 'button') 
      else
        link_to('check', check_admin_client_log_path(item), :method => :put,:class => 'button')
      end
    end
    default_actions
  end

  controller do
    def index
      if params[:start_date].blank? and params[:end_date].blank?
        @client_logs= ClientLog.all.page(params[:page]).per(10)
      else
        @client_logs= ClientLog.from_to(params[:start_date], params[:end_date]).page(params[:page]).per(10)
      end
    end
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
end

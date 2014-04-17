ActiveAdmin.register ClientLog do
    index do
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

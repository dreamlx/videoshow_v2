ActiveAdmin.register ClientLog do
    index do
      column :id 
      column :created_at
      column :logfile do |c|
        link_to c.client_log, c.client_log.url
      end
    end

end

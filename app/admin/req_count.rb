ActiveAdmin.register ReqCount do

  sidebar :search do
    render 'search'
  end

  config.filters =false
  
  #config.filters =false
  #filter :req_day

  actions :all, except: [:edit, :new]

  index do                            
    column :req_day                     
    column :recent_num        
    column :featured_num          
    #default_actions                   
  end 


  controller do
    def index
      items = []
      if !params[:start_date].blank? && !params[:end_date].blank?
         items = ReqCount.where(:req_day=>{'$gte' => params[:start_date]}).where(:req_day=>{'$lte' => params[:end_date]}).page(params[:page]).per(params[:per_page]||20)
      elsif !params[:start_date].blank?
         items = ReqCount.where(:req_day=>{'$gte' => params[:start_date]}).page(params[:page]).per(params[:per_page]||20)
      elsif !params[:end_date].blank?
         items = ReqCount.where(:req_day=>{'$lte' => params[:end_date]}).page(params[:page]).per(params[:per_page]||20)
      else
         items = ReqCount.page(params[:page]).per(params[:per_page]||20)
      end
      @req_counts = items
      
      #items = ReqCount.all
      #if params[:start_date].blank? or params[:end_date].blank?
        # skip
      #else
      #  items= items.from_to(params[:start_date], params[:end_date])
      #end
      #if !params[:start_date].blank?
      #  items= items.from_to_start(params[:start_date])
      #end
      #if !params[:end_date].blank?
      #  items= items.from_to_end(params[:end_date])
      #end
      #items = items.where(os_version: params[:os_version]) unless params[:os_version].blank?
      #@req_counts = items.page(params[:page]).per(params[:per_page]||20)

    end
  end




end
ActiveAdmin.register BlackList do
   #config.sort_order = 'name_asc'

  #sidebar :search do
  #  render 'search'
  #end

  config.filters =false

  #actions :all, except: [:destroy,:edit, :new,:show]

  index do
  	column :username
    default_actions
  end


  controller do
    def index
      items = []
      #binding.pry
      items = BlackList.from_to_userName(params[:userName]).page(params[:page]||1).per(params[:per_page]||20)
      #items = BlackList.where(:username => params[:userName]).page(params[:page]||1).per(params[:per_page]||20)
      @black_lists = items
    end
  end
end

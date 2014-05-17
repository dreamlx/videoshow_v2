ActiveAdmin.register HomeTopAdvert do


	#sidebar :search do
  #  render 'search'
  #end

  #form :partial => "form"

  config.filters =false

  #actions :all, except: [:destroy,:edit, :new,:show]
  #actions :all, except: [:destroy,:edit, :new]

  index do
    #selectable_column

    column  :name do |item|
      item["name"]
    end
    column  :type do |item|
      item["type"]
    end
    column :pic_url do |item|
       if !item["pic_url"].nil?
         image_tag "http://"+item["pic_url"],:size => '110x60'
       end
    end
    column :sort do |item|
      item["sort"]
    end
    column :ctime do |item|
      #item["status"]
      if !item["ctime"].nil?
        item["ctime"].strftime("%Y-%m-%d")
      end
      
    end

    column :Release do |item|
      if item.status == 1
        link_to('Cancel', unpubs_admin_home_top_advert_path(item), :method => :put,:class => 'button') 
      else
        link_to('Release', pubs_admin_home_top_advert_path(item), :method => :put,:class => 'button')
      end
    end
    #column :action do |item|
    #    link_to('Delete', deletes_admin_featured_video_path(item), :method => :delete,:class=>"member_link delete_link",:confirm=>"Are you sure you want to delete this?",:rel=>"nofollow") 
    #end
    default_actions
  end


  controller do
    def index
      #binding.pry
      items = []
      if !params[:type].blank? && !params[:name].blank?
         items = HomeTopAdvert.where(:"type" => params[:type].to_i,:'name'=> params[:name]).page(params[:page]).per(params[:per_page]||20)
      elsif !params[:orderNo].blank?
         items = HomeTopAdvert.where(:"type" => params[:type].to_i).page(params[:page]).per(params[:per_page]||20)
      elsif !params[:userName].blank?
         items = HomeTopAdvert.where(:"name" => params[:name]).page(params[:page]).per(params[:per_page]||20)
      else
         items = HomeTopAdvert.page(params[:page]).per(params[:per_page]||20)
      end

      @home_top_adverts = items
    end

    def new
      #render :file => 'admin/home_top_adverts/newUpload.rhtml'
      #render :file => 'admin/home_top_adverts/new.html.erb'
      #binding.pry
      @home_top_advert = HomeTopAdvert.new
      respond_to do |format|
        format.html # new.html.erb
        format.json { render :json => @home_top_advert }
      end
    end


    # GET /HomeTopAdvert/1/edit
    def edit
      @home_top_advert = HomeTopAdvert.find(params[:id])
    end

    # POST /HomeTopAdvert
    # POST /HomeTopAdvert.json
    def create
        #binding.pry
        # upload img file
        upload=params[:upload]
        name =  upload['datafile'].original_filename  
        directory = "/var/ftp/videoshow/homeTop/"
        # create the file path  
        path = File.join(directory, name)  
        # write the file  
        File.open(path, "wb") { |f| f.write(upload['datafile'].read) } 

        #File.delete("#{RAILS_ROOT}/dirname/#{@filename}")   
        #if File.exist?("#{RAILS_ROOT}/dirname/#{@filename}") 
        ##

        @home_top_advert = HomeTopAdvert.new(params[:homeTopAdvert])
        respond_to do |format|
          if @home_top_advert.save
            format.html { redirect_to @home_top_advert, :notice => 'Home top advert was successfully created.' }
            format.json { render :json => @home_top_advert, :status => :created, :location => @home_top_advert }
          else
            format.html { render :action => "new" }
            format.json { render :json => @home_top_advert.errors, :status => :unprocessable_entity }
          end
        end
    end

    # PUT /HomeTopAdvert/1
    # PUT /HomeTopAdvert/1.json
    def update
      @home_top_advert = HomeTopAdvert.find(params[:id])

      respond_to do |format|
        if @home_top_advert.update_attributes(params[:home_top_advert])
          format.html { redirect_to @home_top_advert, :notice => 'Home top advert was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render :action => "edit" }
          format.json { render :json => @home_top_advert.errors, :status => :unprocessable_entity }
        end
      end
    end

  end


  member_action :pubs, :method => :put do
    item = HomeTopAdvert.find(params[:id])
    item.status=1
    item.save
    redirect_to  admin_home_top_adverts_path
  end

  member_action :unpubs, :method => :put do
    item = HomeTopAdvert.find(params[:id])
    item.status=0
    item.save
    redirect_to  admin_home_top_adverts_path
  end

  #form :partial => "form"
  
  #form do |f|
   #   f.inputs "new HomeTopAdvert" do
    #    f.input :name
     #   f.input :pic_url, :label => "pic url"
      #end 
      #f.actions
  #end



  #form do |f|
  #   binding.pry
  #  f.inputs "Details" do
  #    f.input :name
      #f.selectable_column :type
      #f.select :type,[["", ""],["No", "0"], ["Yes", "1"]], :required => true
   #   f.select :type, options_for_select([['管理员', true], ['用户', false]], home_top_advert.type)
  #    f.input :advert_url, :label => "advert url"
      #<%= f.select :admin, options_for_select([['管理员', true], ['用户', false]], user.admin) %>
   # end
    #f.inputs "Content" do
    #  f.input :adver_url
    #end
   # f.actions
  #end

  
end

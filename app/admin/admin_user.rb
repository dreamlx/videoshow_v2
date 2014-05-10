ActiveAdmin.register AdminUser do     
  index do                            
    column :email                     
    column :current_sign_in_at        
    column :last_sign_in_at           
    column :sign_in_count             
    default_actions                   
  end                                 

  filter :email                       

  form do |f|                         
    f.inputs "Admin Details" do       
      f.input :email                  
      f.input :password               
      f.input :password_confirmation  
    end                               
    f.actions                         
  end                                 
end   


=begin 
ActiveAdmin.register AdminUser do
  menu :label => "Users"

  filter :email
  filter :last_sign_in_at
  
  index do
    column :id
    column :email
    column "Last Sign in", :last_sign_in_at
    default_actions
  end
  
  show :title => :email do 
    attributes_table :email, :last_sign_in_at, :created_at
  end
  
  form do |f|
    f.inputs do
      f.input :email
      f.input :admin
      f.input :password, :type => :password
      f.input :password_confirmation, :type => :password
    end
    
    f.buttons
  end

end                                
=end
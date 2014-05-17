class Api::V1::AdvertController < ApplicationController

  def homeTop #tag_recent_media
    page = params[:page].to_i
    homeTopAdvert = HomeTopAdvert.where(:"status" => 1).asc(:"sort").paginate(:page => page, per_page: 10)
    
    #binding.pry
    format_ins = []
    homeTopAdvert.each do |i|
      item =  {"type"=>i.type,"name" => i.name, "pic_url" => i.pic_url,"advert_url" =>i.advert_url,"advert_content" =>i.advert_content}
      #item.store("d", 42)
      format_ins << item
    end

    render json: format_ins.to_json, :callback => params[:callback]

  end
   


end

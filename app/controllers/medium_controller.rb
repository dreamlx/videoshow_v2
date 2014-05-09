class MediumController < ApplicationController
  def index
  end

  def featured
    page = params[:page]
    blacklist = []
    BlackList.all.each {|b| blacklist << b.username}
    @instagrams = FeaturedVideo.filter_blacklist(blacklist).featured.has_video.instagram_desc.paginate(:page => page, per_page: 20)
  end

  def recent
    page = params[:page]
    blacklist = []
    BlackList.all.each {|b| blacklist << b.username}
    @instagrams = FeaturedVideo.filter_blacklist(blacklist).has_video.instagram_desc.paginate(:page => page, per_page: 20)
  end
end

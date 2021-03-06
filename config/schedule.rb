# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :environment, "development"

every 4.minutes do
#every 90.seconds do
  # 自动从远端获取有tag的instagram media
  runner "Category.get_all_tags"
end

# every 1.days do
#   # auto likes
#   runner "FeaturedVideo.auto_likes"
# end

every 1.days do
  # auto likes
  runner "FeaturedVideo.generate_featured_cache"
end

every 1.days, :at => '0:30 am' do
  # video delete check update 
  runner "FeaturedVideo.check_del_update"
end


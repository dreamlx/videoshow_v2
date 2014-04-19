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

every 1.minutes do
  # 自动从远端获取有tag的instagram media
  runner "Category.get_all_tags"
end

every 5.minutes do
  runner "FeaturedVideo.clear_bad_item"
end

every 5.minutes do
  #skip, limit
  runner "FeaturedVideo.update_all(30,50)"
end

every 10.minutes do
  runner "FeaturedVideo.update_all(100,100)"
end

every 1.hours do
  runner "FeaturedVideo.update_all(100,300)"
end
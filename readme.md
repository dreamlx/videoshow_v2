#roadmap

---

# 使用redis-store
    https://github.com/redis-store/redis-store
osx 上
`brew install redis`

rails 配置 (http://www.oschina.net/question/213217_58914)
`gem 'redis-rails'`
`gem 'redis-rack-cache' # optional`


#使用 jgrep
*. JGrep is a Ruby-based CLI tool and API for parsing and displaying JSON data using a logical expression syntax.

# whenever
https://github.com/javan/whenever

    Update the crontab
    After setting up the rake task, you need to run following command in the console to tell Whenever to start running your periodic tasks:

`whenever --update-crontab`

    If you want to check that the gem correctly scheduled your cron task, you can use the command “crontab -l” to list all cron tasks.

--------------
# 安装步骤
## mongodb
http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/

## 建立服务器环境
## 安装 rvm/ruby/passenger/nginx/git
http://ruby-china.org/wiki/install-rails-on-ubuntu-12-04-server

## clone 项目到本地
git clone git://github.com/dreamlx/videoshow_v2.git

## 自动部署
采用capistrano, 修改文件项目config/deploy.rb和config/deploy/production.rb

## 初始化服务器部署目录
    $cap production deploy

## cp 基础设置文件到服务器

`$scp ./config/schedule.rb root@api.videoshowapp.com:/var/www/video_show/shared/config`

`$scp ./config/mongoid.yml root@api.videoshowapp.com:/var/www/video_show/shared/config`

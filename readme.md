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
    
    rvm install 2.1.1  # ruby last version

## clone 项目到本地
git clone git://github.com/dreamlx/videoshow_v2.git

## bundle 本地环境
    $ cd videoshow_v2
    $ bundle install
    $ whenever --update-crontab

## backup & restore
http://docs.mongodb.org/manual/tutorial/backup-with-mongodump/

## 安装信息
1. 程序安装路径： /home/ubuntu/www/videoshow_v2
2. 更新方式: $git pull origin master # 从 github抓差异代码
3. nginx安装路径 /opt/nginx
3. 网站conf, /opt/nginx/conf/niginx.conf
4. 如何重启服务： $sudo service nginx restart

## api
* instagram认证
`http://api.videoshowapp.com:8087/api/v1/oauth/connect`

action:get

result:

    {"code":"success","result":{"access_token":"789981918.80d957c.f408bb1006844250907d9d2a34df66c4","user":{"username":"videoshowapp","bio":"VideoShow:  Create awesome video from your photos,videos, with beautiful music, text, effects.  \nTag your videos #videoshowapp","website":"http://videoshowapp.com","profile_picture":"http://images.ak.instagram.com/profiles/profile_789981918_75sq_1386833898.jpg","full_name":"","id":"789981918"}}}

* like_media
action: post    
    curl 'http://api.videoshowapp.com:8087/api/v1/medium/690454531071358639_190726100/like_media' -F "access_token=789981918.80d957c.f408bb1006844250907d9d2a34df66c4"

result:
    
    {"meta":{"code":200},"data":null}%   

*unlike_media

action: delete    
     curl -X DELETE 'http://api.videoshowapp.com:8087/api/v1/medium/690454531071358639_190726100/unlike_media' -F "access_token=789981918.80d957c.f408bb1006844250907d9d2a34df66c4"

result:
    
    {"meta":{"code":200},"data":null}%   
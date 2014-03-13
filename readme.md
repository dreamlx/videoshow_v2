#roadmap
* 输出tag search json api(完成)
* 使用whenever 后台自动周期执行 tag search， 搜索 官方账号likes（完成）
* 增加capistrano支持
* 缓存搜索结果，和存储结果做比较，保持差异部分
* 使用monagodb作为json数据库
* 生成publish 输出结果，缓存到内存
* 寻找阿里云部署方案

======================

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
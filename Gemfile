source 'https://rubygems.org'
gem 'rake'
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'
gem 'activeadmin-mongoid'
gem 'rails', '3.2.13'
gem 'whenever', :require => false
gem 'videojs_rails'

gem 'jquery-rails'
gem 'jquery_mobile_rails'
gem 'jquery-ui-rails'

gem 'unicorn'
gem 'rabl'
gem 'oj'

gem "typhoeus"
gem 'capistrano', '~> 3.1'
gem 'capistrano-rails', '~> 1.1'
gem 'capistrano-rvm'
gem 'capistrano-bundler', '>= 1.1.0'
gem 'curb'
gem 'mongoid', '~>3'
gem "will_paginate_mongoid"
gem "bson_ext"

gem "koala", "~> 1.8.0rc1" #facebook api
gem "instagram"
gem 'haml'
gem "pry"
gem 'pry-rails'

gem 'devise'
gem 'figaro'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end


group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'quiet_assets'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end
group :test do
  gem 'capybara'
  gem 'cucumber-rails', :require=>false
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
  gem 'launchy'
  gem 'mongoid-rspec'
end

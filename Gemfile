source 'https://rubygems.org'
gem 'activeadmin-mongoid'
gem 'rails', '3.2.13'
gem 'whenever', :require => false
gem 'videojs_rails'
gem 'jquery_mobile_rails'
gem 'jquery-ui-rails'
gem 'unicorn'
gem 'rabl'
gem 'oj'
gem 'therubyracer'

gem 'capistrano', '~> 3.1'
gem 'capistrano-rails', '~> 1.1'
gem 'capistrano-rvm'
gem 'capistrano-bundler', '>= 1.1.0'

gem 'mongoid', '~>3'
gem "will_paginate_mongoid"
gem "bson_ext"

gem "koala", "~> 1.8.0rc1" #facebook api
gem "instagram"
gem 'haml'
gem "pry"
gem 'pry-rails'
#gem 'pg'

gem 'devise'
gem 'figaro'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#gem 'sqlite3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

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
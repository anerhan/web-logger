source 'https://rubygems.org'

gem 'sinatra-asset-pipeline'

gem 'sinatra', require: false
gem 'sinatra-contrib', path: '../sinatra-contrib'
gem 'sinatra-param'
gem 'sinatra-cross_origin'
gem 'sinatra-can'
gem 'cancancan'

gem 'sinatra-active-model-serializers', github: 'anerhan/sinatra-active-model-serializers'

gem 'rake'
gem 'rack-contrib'
gem 'rack-cors', require: 'rack/cors'
gem 'settingslogic'
gem 'colorize'

gem 'mongoid', '~> 4.0.2'
gem 'bson', '~> 3.1.0'
gem 'bson_ext'
gem 'kaminari'

gem 'bcrypt-ruby', require: 'bcrypt'


group :test, :development do
  gem 'rerun'
  gem 'pry'
  gem 'thin'
end

group :test do
  gem 'rack-test', require: 'rack/test'
  gem 'rspec'
  gem 'factory_girl'
  gem 'mongoid-rspec'
  gem 'fakeweb'
  gem 'database_cleaner'
  gem 'timecop'
  gem 'rspec_api_documentation','~> 4.4.0', github: 'anerhan/rspec_api_documentation'
end

group :production do
  gem 'unicorn'
end

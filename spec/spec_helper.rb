ENV['RACK_ENV'] = 'test'

require 'rubygems'
require 'mongoid-rspec'
require 'sinatra/base'
require 'rack/test'
require File.join(File.dirname(__FILE__), '../application')
require "rspec_api_documentation/dsl"

FactoryGirl.find_definitions
# FakeWeb.allow_net_connect = false

Dir[File.join(File.dirname(__FILE__), '../spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.color = true
  config.tty   = true
  config.include FactoryGirl::Syntax::Methods
  config.include Mongoid::Matchers
  config.include Rack::Test::Methods

  config.before(:all) do
    FactoryGirl.reload
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:each) do
    Timecop.return
  end
end

RspecApiDocumentation.configure do |config|
  config.docs_dir = Pathname.new(App.settings.root).join("doc")
  config.app = App
  config.api_name = "Web Logger"
  config.format = :html
end

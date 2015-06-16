# encoding: utf-8

require 'bundler'
require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/asset_pipeline'
# require 'sprockets'
# require 'sprockets-helpers'

# Require gems
Bundler.require :default, (ENV['RACK_ENV'] || :development).to_sym
puts "Loaded #{Sinatra::Application.environment.to_s.red} environment"

# Initiate Settings
class Settings < Settingslogic
  source "#{File.dirname(__FILE__)}/config/settings.yml"
end

# Require libs with all APP classes
Dir[File.join(File.dirname(__FILE__), "app/{models,serializers,models/concerns}/*.rb")].each { |f| autoload File.basename(f, '.rb').camelize.to_sym, f }
Dir[File.join(File.dirname(__FILE__), "{app/models/concerns,lib,app}/**/*.rb")].each { |file| require_relative file }


class App < Sinatra::Base
  register Sinatra::Contrib
  register Sinatra::Can

  set :root,        File.dirname(__FILE__)
  set :environment, Sinatra::Application.environment
  set :limit_on_page, 50
  set :views, Proc.new { File.join(root, "app/views") }

  set :assets_precompile, %w(application.js application.css *.png *.jpg *.svg *.eot *.ttf *.woff *.woff2)
  set :assets_prefix, %w(app/assets vendor/assets)
  set :assets_host, '<id>.example.org'
  # set :assets_protocol, :http
  set :assets_css_compressor, :sass
  set :assets_js_compressor, :uglifier
  set :digest_assets, false
  register Sinatra::AssetPipeline


  configure do
    enable :cross_origin
    use Rack::PostBodyContentTypeParser
    use Rack::CommonLogger, File.new(File.join(settings.root, 'log', "#{settings.environment}.log"), 'a+').tap { |f| f.sync = true }
    use Rack::Cors do
      allow do
        origins '*'
        resource '/*', headers: :any, methods: [:post, :put, :get, :delete, :options]
      end
    end
    Dir[File.join(settings.root, "config/initializers/*.rb")].each { |file| load file }
  end

  Dir[File.join(settings.root, "app/{controllers}/*.rb")].each do |file|
    register File.basename(file, '.rb').classify.constantize
  end

  namespace "/api/v1" do
    helpers do
      Dir[File.join(settings.root, "app/{helpers}/*.rb")].each do  |file|
        include File.basename(file, '.rb').classify.constantize
      end
    end
    Dir[File.join(settings.root, "app/{before_filters,controllers/api/v1}/*.rb")].each do |file|
      register File.basename(file, '.rb').classify.constantize
    end
  end
end





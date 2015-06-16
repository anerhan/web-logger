require_relative 'application'

Dir.glob('lib/tasks/*.rake').each { |r| load r }

unless App.settings.environment == :production
  require 'rspec_api_documentation'
  load 'tasks/docs.rake'
end


require 'sinatra/asset_pipeline/task'
Sinatra::AssetPipeline::Task.define! App

Mongoid.configure do |config|
  config.sessions = Settings.mongoid.sessions
  config.options  = Settings.mongoid.options
end

module ApplicationController
  def self.registered(app)
    app.get "/" do
      erb :application
    end
  end
end

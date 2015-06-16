module JsonContentType
  def self.registered(app)
    app.before do
      content_type :json
    end
  end
end

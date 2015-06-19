module JsonContentType
  def self.registered(app)
    app.before do
      content_type (params[:format] || :json).to_s.gsub('.','')
    end
  end
end

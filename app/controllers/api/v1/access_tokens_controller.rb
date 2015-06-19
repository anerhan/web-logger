module AccessTokensController
  def self.registered(app)
    app.get "/access_tokens/:id" do
      serialize_and_response AccessToken.find_by(tmp_token: params[:id]) do |object|
        object.reset_tmp_token! if object.present?
      end
    end

    app.post "/access_tokens" do
      serialize_and_response AccessToken.new(params[:access_token]) do |object|
        object.user = current_user
        object.save
      end
    end
  end
end

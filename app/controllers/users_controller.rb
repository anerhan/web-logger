module UsersController
  def self.registered(app)
    app.get "/users.json" do
      authorize! :read, User
      serialize_and_response User.limit(limit).offset(offset)
    end

    app.get "/users/:id.json" do
      load_and_authorize! User
      serialize_and_response @user
    end

    app.post "/users.json" do
      authorize!(:create, User)
      serialize_and_response User.new(params[:user]) do |object|
        object.save
      end
    end

    app.put '/users/:id.json' do
      load_and_authorize! User
      serialize_and_response @user do |object|
        object.update_attributes params[:user]
      end
    end

    app.delete '/users/:id.json' do
      load_and_authorize! User
      serialize_and_response @user do |object|
        object.destroy
      end
    end
  end
end

module UsersController
  def self.registered(app)
    app.get "/users" do
      authorize! :read, User
      serialize_and_response User.limit(limit).offset(offset)
    end

    app.get "/users/:id" do
      load_and_authorize! User
      serialize_and_response User.find(params[:id])
    end

    app.post "/users" do
      authorize! :create, User
      serialize_and_response User.new(params[:user]) do |object|
        object.save
      end
    end

    app.put '/users/:id' do
      load_and_authorize! User
      serialize_and_response @user do |object|
        object.update_attributes params[:user]
      end
    end

    app.delete '/users/:id' do
      load_and_authorize! User
      serialize_and_response @user do |object|
        object.destroy
      end
    end
  end
end

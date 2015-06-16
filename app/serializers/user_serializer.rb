class UserSerializer < BaseSerializer
  attributes :first_name, :last_name, :email, :position

  def position
    User::POSITIONS[object.position]
  end
end

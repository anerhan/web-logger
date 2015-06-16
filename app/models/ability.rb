class Ability
  include CanCan::Ability
  alias_method :able_to?, :can?
  attr_reader  :user

  def initialize(user, scope)
    alias_action :list, :view, to: :read

    return unless (@current_user = user)

    can :manage, User
  end
end

class Ability
  include CanCan::Ability
  alias_method :able_to?, :can?
  attr_reader  :user

  def initialize(user, scope = nil)
    alias_action :list, :view, to: :read

    return unless (@current_user = user)
    if user.admin?
      can :manage, :all
    elsif user.user?
      can :manage, User, id: user.id
      can :read, Stage
      can :read, Project
    end
  end
end

class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :edit, User, id: user.id

      if user.admin?
        can :manage, :all
      end
    end
  end
end

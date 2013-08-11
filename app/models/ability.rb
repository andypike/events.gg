class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :edit, User, id: user.id
    end
  end
end

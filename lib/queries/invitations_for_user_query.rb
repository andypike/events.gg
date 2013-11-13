class InvitationsForUserQuery < Queryable
  def initialize(user, relation = Invitation.all)
    @user = user
    @relation = relation
  end

  def query
    @relation.where(user: @user)
  end
end

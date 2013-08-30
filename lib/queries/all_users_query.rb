class AllUsersQuery < QueryBase
  def initialize(relation = User.all)
    @relation = relation
  end

  def query
    @relation.order("created_at DESC")
  end
end
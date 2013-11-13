class AllGamesQuery < Queryable
  def initialize(relation = Game.all)
    @relation = relation
  end

  def query
    @relation.order("name ASC")
  end
end

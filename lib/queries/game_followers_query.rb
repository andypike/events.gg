class GameFollowersQuery < QueryBase
  def initialize(game, relation = Follower.all)
    @game = game
    @relation = relation
  end

  def query
    @relation.where(game: @game)
  end
end
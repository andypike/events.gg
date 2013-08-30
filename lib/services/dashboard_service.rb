class DashboardService
  def self.get_stats
    Dashboard.new(user_count: AllUsersQuery.new.count, game_count: AllGamesQuery.new.count)
  end
end

class Dashboard
  attr_reader :user_count, :game_count

  def initialize(user_count: 0, game_count: 0)
    @user_count = user_count
    @game_count = game_count
  end
end
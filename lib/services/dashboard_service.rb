class DashboardService
  def self.get_stats
    Dashboard.new(
      user_count: AllUsersQuery.new.count, 
      game_count: AllGamesQuery.new.count,
      organisations_count: AllOrganisationsQuery.new.count
    )
  end
end
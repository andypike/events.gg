class DashboardService
  def self.get_stats
    Dashboard.new(user_count: User.count)
  end
end

class Dashboard
  attr_reader :user_count

  def initialize(user_count: 0)
    @user_count = user_count
  end
end
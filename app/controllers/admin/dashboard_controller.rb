class Admin::DashboardController < Admin::BaseController
  def index
    @dashboard = DashboardService.get_stats
  end
end
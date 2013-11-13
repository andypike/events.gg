class Dashboard
  attr_reader :user_count, :game_count, :organisations_count

  def initialize(user_count: 0, game_count: 0, organisations_count: 0)
    @user_count = user_count
    @game_count = game_count
    @organisations_count = organisations_count
  end
end

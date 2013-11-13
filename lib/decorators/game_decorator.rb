class GameDecorator < Draper::Decorator
  delegate_all

  def number_of_followers
    GameFollowersQuery.new(object).count
  end
end

class Admin::GamesController < Admin::BaseController
  def index
    @games = AllGamesQuery.new.decorated
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      redirect_to admin_games_path, notice: "The game was successfully added"
    else
      render :new
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])

    if @game.update_attributes(game_params)
      redirect_to admin_games_path, notice: "The game was successfully updated"
    else
      render :edit
    end
  end

  private

    def game_params
      params.require(:game).permit(:name, :status)
    end
end

class UsersController < ApplicationController
  def new
    @games = games
    @user = User.default
  end

  def create
    @user = RegisterMember.register(user_params, session)

    if @user.valid?
      redirect_to root_url, notice: "You have successfully created an account."
    else
      render :new
    end
  end

  def edit
    prep_for_edit
  end

  def update
    prep_for_edit

    if @user.update_attributes(user_params)
      redirect_to root_url, notice: "Your settings were successfully updated"
    else
      render :edit
    end
  end

  private

    def user_params
      params
        .require(:user)
        .permit(:name, :email, :password, :password_confirmation, :time_zone, game_ids: [])
    end

    def prep_for_edit
      authorize! :edit, current_user
      @games = games
      @user = User.find(current_user.id)  # Reload in case of invalid data so user is unaffected
    end

    def games
      AllGamesQuery.new
    end
end

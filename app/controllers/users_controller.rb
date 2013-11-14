class UsersController < ApplicationController
  def new
    @games = games
    @user = User.default
  end

  def create
    register_member = RegisterMember.new(params[:user], session)

    register_member.on(:success) do
      redirect_to root_url, notice: "You have successfully created an account."
    end

    register_member.on(:failure) do |user|
      @user = user
      render :new
    end

    register_member.register
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

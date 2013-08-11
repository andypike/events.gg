class UsersController < ApplicationController
  def new
    @user = User.new(time_zone: "UTC")
  end

  def create
    @user = User.new(user_params)

    if @user.save
      SecurityService.login(@user, session)
      redirect_to root_url, notice: "You have successfully created an account."
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :time_zone)
    end
end
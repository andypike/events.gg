class UsersController < ApplicationController
  def new
    @user = User.default
  end

  def create
    @user = RegistrationService.register(user_params, session)

    if @user.valid?
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
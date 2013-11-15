class SessionsController < ApplicationController
  def new
  end

  def create
    authenticate_user = AuthenticateUser.new(session, params[:session])

    authenticate_user.on(:success) do
      redirect_to root_path, notice: "You have successfully logged into your account."
    end

    authenticate_user.on(:failure) do
      redirect_to login_path, alert: "Either your email address or password wasn't valid."
    end

    authenticate_user.authenticate
  end

  def destroy
    SecurityService.logout(session)
    redirect_to root_path, notice: "You have successfully logged out."
  end
end

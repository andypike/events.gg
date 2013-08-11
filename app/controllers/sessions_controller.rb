class SessionsController < ApplicationController
  def new
  end

  def create
    if user = SecurityService.authenticate(session_params, session)
      redirect_to root_path, notice: "You have successfully logged into your account."
    else
      redirect_to login_path, alert: "Either your email address or password wasn't valid."
    end
  end

  def destroy
    SecurityService.logout(session)
    redirect_to root_path, notice: "You have successfully logged out."
  end

  private
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
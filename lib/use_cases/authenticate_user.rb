class AuthenticateUser
  include Wisper::Publisher

  def initialize(session, params)
    @session = session
    @params = secure_params(params)
  end

  def authenticate
    user = User.find_by(email: @params[:email])
    authenticated = user && user.authenticate(@params[:password])

    if authenticated
      SecurityService.login(user, @session)
      publish :success, user
    else
      publish :failure
    end
  end

  private

    def secure_params(params)
      ActionController::Parameters.new(params).permit(:email, :password)
    end
end

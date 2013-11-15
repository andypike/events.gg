class AuthenticateUser
  include Wisper::Publisher

  def initialize(session, params)
    @session = session
    @params = secure_params(params)
  end

  def authenticate
    user = User.find_by(email: @params[:email])

    if authenticated?(user)
      SecurityService.login(user, @session)
      publish :success, user
    else
      publish :failure
    end
  end

  private

    def authenticated?(user)
      user && user.authenticate(@params[:password])
    end

    def secure_params(params)
      ActionController::Parameters.new(params).permit(:email, :password)
    end
end

class RegisterMember
  include Wisper::Publisher

  def initialize(params, session_store)
    @params = secure_params(params)
    @session_store = session_store
  end

  def register
    user = User.new(@params)
    user.role = "normal"

    if user.save
      SecurityService.login(user, @session_store)
      publish :success, user
    else
      publish :failure, user
    end
  end

  private

    def secure_params(params)
      ActionController::Parameters.new(params)
        .permit(:name, :email, :password, :password_confirmation, :time_zone, game_ids: [])
    end
end

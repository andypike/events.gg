class SecurityService
  LOGIN_SESSION_KEY = 'user_id'

  def self.authenticate(session_params, session)
    user = User.find_by(email: session_params[:email])
    authenticated = user && user.authenticate(session_params[:password])

    login(user, session) if authenticated

    user
  end

  def self.login(user, session)
    session[LOGIN_SESSION_KEY] = user.id
  end

  def self.logout(session)
    session[LOGIN_SESSION_KEY] = nil
  end

  def self.current_user(session)
    id = session[LOGIN_SESSION_KEY]

    User.where(:id => id).first if id
  end
end
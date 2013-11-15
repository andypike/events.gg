class SecurityService
  LOGIN_SESSION_KEY = "user_id"

  def self.login(user, session)
    session[LOGIN_SESSION_KEY] = user.id
  end

  def self.logout(session)
    session[LOGIN_SESSION_KEY] = nil
  end

  def self.current_user(session)
    id = session[LOGIN_SESSION_KEY]
    User.where(id: id).first if id
  end
end

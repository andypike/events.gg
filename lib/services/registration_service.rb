class RegistrationService
  def self.register(user_params, session)
    user = User.new(user_params)
    user.role = "normal"

    if user.save
      SecurityService.login(user, session)
    end

    user
  end
end

class User < ActiveRecord::Base
  has_secure_password

  validates :name,      presence: true
  validates :time_zone, presence: true
  validates :password,  presence: { if: :password_required? }, 
                        length: { minimum: 6, if: :password_required? }
  validates :email,     uniqueness: {case_sensitive: false},
                        presence: true, 
                        email_format: true

  private 
    def password_required?
      password_digest.blank? || !password.blank?
    end
end

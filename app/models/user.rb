class User < ActiveRecord::Base
  has_many :followers
  has_many :games, through: :followers
  has_secure_password

  ROLES = %w{normal admin}

  validates :name,      presence: true
  validates :time_zone, presence: true
  validates :password,  presence: { if: :password_required? }, 
                        length: { minimum: 6, if: :password_required? }
  validates :email,     uniqueness: {case_sensitive: false},
                        presence: true, 
                        email_format: true
  validates :role,      presence: true, 
                        inclusion: { in: ROLES }

  ROLES.each do |r|
    define_method "#{r}?" do
      role == r
    end
  end

  def self.default
    self.new time_zone: "UTC"
  end

  private 
    def password_required?
      password_digest.blank? || !password.blank?
    end
end

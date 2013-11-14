class Invitation < ActiveRecord::Base
  belongs_to :organisation
  belongs_to :user

  ROLES = %w{member manager}
  STATUSES = %w{pending accepted rejected}

  validates :user_id,
            presence: true

  validates :organisation_id,
            presence: true

  validates :role,
            presence: true,
            inclusion: { in: ROLES }

  validates :status,
            presence: true,
            inclusion: { in: STATUSES }

  ROLES.each do |r|
    define_method "#{r}?" do
      role == r
    end
  end

  STATUSES.each do |s|
    define_method "#{s}?" do
      status == s
    end
  end
end

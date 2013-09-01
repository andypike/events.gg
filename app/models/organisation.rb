class Organisation < ActiveRecord::Base
  mount_uploader :logo, OrganisationLogoUploader

  has_many :invitations
  has_many :users, through: :invitations

  STATUSES = %w{pending_approval approved rejected}

  validates :name,    presence: true
  validates :status,  presence: true, inclusion: { in: STATUSES }

  def self.default
    self.new
  end
end

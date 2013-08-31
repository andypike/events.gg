class Organisation < ActiveRecord::Base
  has_many :invitations
  has_many :users, through: :invitations

  def self.default
    self.new
  end
end

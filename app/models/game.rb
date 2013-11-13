class Game < ActiveRecord::Base
  has_many :followers
  has_many :users, through: :followers

  STATUSES = %w{active suggestion}

  validates :name,
    presence: true

  validates :status,
    presence: true,
    inclusion: { in: STATUSES }
end

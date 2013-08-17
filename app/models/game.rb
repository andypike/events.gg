class Game < ActiveRecord::Base
  STATUSES = %w{active suggestion}

  validates :name,    presence: true
  validates :status,  presence: true, inclusion: { in: STATUSES }
end

class AddStatusToOrganisation < ActiveRecord::Migration
  def change
    add_column :organisations, :status, :string, default: 'pending_approval', null: false
  end
end

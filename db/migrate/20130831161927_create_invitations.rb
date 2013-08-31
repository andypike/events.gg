class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :user_id, null: false
      t.integer :organisation_id, null: false
      t.string :status, null: false
      t.string :role, null: false

      t.timestamps
    end
    
    add_index :invitations, :user_id
    add_index :invitations, :organisation_id
  end
end

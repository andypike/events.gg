class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.integer :game_id
      t.integer :user_id

      t.timestamps
    end

    add_index :followers, :game_id
    add_index :followers, :user_id
  end
end

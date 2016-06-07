class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :type
      t.integer :user_id
      t.integer :restaurant_id

      t.timestamps null: false
    end
  end
end

class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :restaurant_id
      t.datetime :appointment

      t.timestamps null: false
    end
  end
end

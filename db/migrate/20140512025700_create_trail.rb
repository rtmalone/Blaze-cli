class CreateTrail < ActiveRecord::Migration
  def change
    create_table :trails do |t|
      t.string :name
      t.string :date
      t.integer :activity_id
      t.string :length
      t.integer :difficulty_id
      t.integer :trail_type_id
      t.string :park
      t.string :state
      t.string :notes
      t.timestamps
    end
  end
end

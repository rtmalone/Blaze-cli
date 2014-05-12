class CreateTrailType < ActiveRecord::Migration
  def change
    create_table :trail_types do |t|
      t.string :name
      t.timestamps
    end
  end
end

class CreateDifficulty < ActiveRecord::Migration
  def change
    create_table :difficulties do |t|
      t.string :class
      t.string :class_summary
      t.string :tread
      t.string :obstacles
      t.string :features
      t.string :signage
      t.timestamps
  end
end

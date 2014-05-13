# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require_relative '../lib/environment'
Environment.environment = 'production'
require 'csv'

csv_file_path = '../data/activities.csv'

CSV.foreach(csv_file_path) do |row|
  Activity.create!({
    :name => row[0]
  })
end

csv_file_path = '../data/trail_types.csv'

CSV.foreach(csv_file_path) do |row|
  TrailType.create!({
    :name => row[0]
  })
end

csv_file_path = '../data/difficulties.csv'

CSV.foreach(csv_file_path) do |row|
  Difficulty.create!({
    :class => row[0],
    :class_summary => row[1],
    :tread => row[2],
    :obstacles => row[3],
    :features => row[4],
    :signage => row[5]
  })
end

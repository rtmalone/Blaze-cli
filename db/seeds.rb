require 'csv'

csv_file_path = 'data/activities'

CSV.foreach(csv_file_path) do |row|
  

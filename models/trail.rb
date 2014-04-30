class Trail

def self.count
  query = "SELECT count(*) FROM trails"
  result = Environment.database_connection.execute(query)
  result[0]
end

end

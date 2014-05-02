class Trail
  attr_reader :name

  def initialize(name)
    @name = name
    @errors = []
  end

  def self.count
    query = "SELECT count(*) FROM trails"
    result = Environment.database_connection.execute(query)
    result[0]
  end

  def save
    query = "INSERT INTO trails (name) VALUES (?)"
    result = Environment.database_connection.execute(query, name)
    true
  end
end

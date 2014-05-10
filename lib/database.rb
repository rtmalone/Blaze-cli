require 'sqlite3'

class Database < SQLite3::Database
  def initialize(database)
    super(database)
    self.results_as_hash = true
  end
  def self.connection(environment)
    @connection ||= Database.new("db/blaze_#{environment}.sqlite3")
  end

  def create_tables
    self.execute("CREATE TABLE trails (id INTEGER PRIMARY KEY AUTOINCREMENT,
                                       name varchar(50),
                                       date varchar(20),
                                       activity_id number(1),
                                       length varchar(10),
                                       difficulty_id number(1),
                                       trail_type_id number(1),
                                       park varchar(50),
                                       state varchar(50),
                                       notes varchar(150));")
    self.execute("CREATE TABLE trail_type (id INTEGER PRIMARY KEY AUTOINCREMENT, name varchar(50))")
    self.execute("CREATE TABLE activity (id INTEGER PRIMARY KEY AUTOINCREMENT, name varchar(50))")
    self.execute("CREATE TABLE difficulty (id INTEGER PRIMARY KEY AUTOINCREMENT, class varchar(50), class_summary varchar(50))")
    self.execute("INSERT INTO trail_type (name) VALUES ('Loop')")
    self.execute("INSERT INTO trail_type (name) VALUES ('Out and back')")
    self.execute("INSERT INTO activity (name) VALUES ('Hike')")
    self.execute("INSERT INTO activity (name) VALUES ('Run')")
    self.execute("INSERT INTO difficulty (class, class_summary) VALUES ('Class 1', 'Minimally Developed')")
    self.execute("INSERT INTO difficulty (class, class_summary) VALUES ('Class 2', 'Moderately Developed')")
end

  def execute(statement, bind_vars = [])
    Environment.logger.info("Executing: #{statement} with: #{bind_vars}")
    super(statement, bind_vars)
  end
end

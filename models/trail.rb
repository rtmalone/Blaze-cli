class Trail
  attr_reader :id, :errors
  attr_accessor :name, :date, :activity_id, :length, :difficulty_id, :trail_type_id,:park, :state, :notes

  def initialize(name, date, activity_id, length, difficulty_id, trail_type_id, park, state, notes)
    self.name = name
    self.date = date
    self.activity_id = activity_id
    self.length = length
    self.difficulty_id = difficulty_id
    self.trail_type_id = trail_type_id
    self.park = park
    self.state = state
    self.notes = notes
  end

  def self.all
    query = "SELECT * FROM trails;"
    execute_and_instantiate(statement)
  end

  def self.count
    query = "SELECT count(*) FROM trails;"
    result = Environment.database_connection.execute(query)
    result[0][0]
  end

  def self.create(name, date, activity_id, length, difficulty_id, trail_type_id, park, state, notes)
    trail = Trail.new(name, date, activity_id, length, difficulty_id, trail_type_id, park, state, notes)
    trail.save
    trail
  end

  def save
    if self.id
      query = "UPDATE trails
               SET name = ?, date = ?, activity_id = ?, length = ?, difficulty_id = ?,
                   trail_type_id = ?, park = ?, state = ? notes = ?;"
      Environment.database_connection.execute(query, [self.name, self.date, self.activity_id,
                                                      self.length, self.difficulty_id, self.trail_type_id,
                                                      self.park, self.state, self.notes])
    end
    if valid?
      puts "#{self.name} ----- is this running!!!!!!!"
      query = "insert into trails (name, date, activity_id, length, difficulty_id, trail_type_id, park, state, notes) values (?, ?, ?, ?, ?, ?, ?, ?, ?)"
      Environment.database_connection.execute(query, [name, date, activity_id, length, difficulty_id, trail_type_id, park, state, notes])
      puts "#{self.name}<<<<<<<<<<<<"
      @id = Environment.database_connection.execute("SELECT last_insert_rowid();")[0][0]
      true
    else
      false
    end
    puts "#{self.name} !!!!!!!!!!!!!!!!!!!????????"
  end

  def valid?
    @errors = []
    if !name.match /[a-zA-Z]/
      @errors << "'#{self.name}' is not a valid trail name, as it does not include any letters."
    end
    @errors.empty?
  end

  private

  def execute_and_instantiate
    rows = Environment.database_connection.execute(statement, bind_vars)
    results = []
    rows.each do |row|
      trail = Trail.new(row["name"])
      trail.instance_variable_set(:@id, row["id"])
      results << trail
    end
    results
  end
end

class Trail < ActiveRecord::Base
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
    execute_and_instantiate(query)
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

  def self.delete(id)
    query = "DELETE FROM trails WHERE id = ?"
    Environment.database_connection.execute(query, id)
  end

  def self.edit_trail_entry(column, new_entry, id)
    query = "UPDATE trails SET #{column} = '#{new_entry}' WHERE id = #{id}"
    Environment.database_connection.execute(query)
  end

  def self.join_string(result)
    "#{result["id"]} : #{result["name"]}, #{result["date"]}, #{result["activity"]}, #{result["length"]}, #{result["class"]}, #{result["type"]}, #{result["park"]}, #{result["state"]}, #{result["notes"]}"
  end

  def self.last
    query = "SELECT * FROM trails ORDER BY id DESC LIMIT(1)"
    execute_and_instantiate(query)[0]
  end

  def self.print_log
    query = ("SELECT trails.id, trails.name, trails.date, activity.name AS activity, trails.length, difficulty.class, trail_type.name AS type, trails.park, trails.state, trails.notes
              FROM trails
              JOIN activity ON trails.activity_id = activity.id
              JOIN difficulty ON trails.difficulty_id = difficulty.id
              JOIN trail_type ON trails.trail_type_id = trail_type.id;")
    result = Environment.database_connection.execute(query)
    result
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
      query = "insert into trails (name, date, activity_id, length, difficulty_id, trail_type_id, park, state, notes) values (?, ?, ?, ?, ?, ?, ?, ?, ?)"
      Environment.database_connection.execute(query, [name, date, activity_id, length, difficulty_id, trail_type_id, park, state, notes])
      @id = Environment.database_connection.execute("SELECT last_insert_rowid();")[0][0]
      true
    else
      false
    end
  end

  def valid?
    @errors = []
    if !name.match /[a-zA-Z]/
      @errors << "'#{self.name}' is not a valid trail name, as it does not include any letters."
    end
    @errors.empty?
  end

  def to_s
    new_date = date.to_s
    #"#{@id}, #{name}, #{new_date}, #{activity_id}, #{length}, #{difficulty_id}, #{trail_type_id}, #{park}, #{state}, #{notes}"
    "ID: #{@id}, TRAIL: #{name}, DATE: #{new_date}, ACTIVITY: #{activity_id}, LENGTH: #{length}, CLASS: #{difficulty_id}, TYPE: #{trail_type_id}, PARK: #{park}, STATE: #{state}, NOTES: #{notes}"
  end

  private

  def self.execute_and_instantiate(statement, bind_vars = [])
    rows = Environment.database_connection.execute(statement, bind_vars)
    results = []
    rows.each do |row|
      trail = Trail.new(row["name"], row["date"], row["activity_id"], row["length"], row["difficulty_id"], row["trail_type_id"], row["park"], row["state"], row["notes"])
      trail.instance_variable_set(:@id, row["id"])
      results << trail
    end
    results
  end
end

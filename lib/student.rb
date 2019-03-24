class Student
  attr_accessor :name, :grade
  attr_reader :id

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT)
        SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE IF EXISTS students
      SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT into students (name, grade)
      values (?, ?)
      SQL
    DB[:conn].execute(sql, @name, @grade)

    sql = <<-SQL
      SELECT id from students where name = ?
      SQL
    @id = DB[:conn].execute(sql, @name).flatten[0]
  end

  def self.create(attr_hash)
    s = Student.new(nil, nil)
    attr_hash.each {|attr, val| s.send("#{attr}=", val)}
    s.save
    s
  end
  
end

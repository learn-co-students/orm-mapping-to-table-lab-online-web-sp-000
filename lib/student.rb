class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
        )
        SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql =  "DROP TABLE students"

    DB[:conn].execute(sql)
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
  end

  def save
    sql = "INSERT INTO students (name, grade) VALUES (?, ?)"
    statement = DB[:conn].prepare(sql)
    statement.execute(self.name, self.grade)
    @id = DB[:conn].last_insert_row_id
    self
  end

end
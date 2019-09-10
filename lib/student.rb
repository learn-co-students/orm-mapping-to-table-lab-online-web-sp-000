# Remember, you can access your database connection anywhere in this class
#  with DB[:conn]

class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      )
      SQL
      DB[:conn].execute(sql)      #grabbed this syntax from last lesson
  end

  def self.drop_table             #drops students table from the DB
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end

  def save                        #saves individual instance of Student class to the DB
    sql = <<-SQL                  #heredoc multi-line SQL statement. Interpolate bound parameters
      INSERT INTO students (name, grade)
      VALUES(?, ?)
      SQL
      DB[:conn].execute(sql, self.name, self.grade)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:)            #takes in a hash of attr, uses metaprogramming to instanitate new student object
    student = Student.new(name, grade)
    student.save
    student                                   #returns student object that was created
  end
end

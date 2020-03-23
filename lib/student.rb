class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @id = id
    @name = name
    @grade = grade
  end

  def self.create_table
    #below is a HEREDOC
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
      )
      SQL

      DB[:conn].execute(sql)  #execute SQL statement on database table
  end

  def self.drop_table
    sql= <<-SQL
    DROP TABLE students
    SQL
    DB[:conn].execute(sql) #execute SQL statement on database table
  end

  def save
    #this method really persists the student instance copy to the database

    #use bound parameters to pass the given student's name and grade into the SQL statement
    #At the end of your #save method, you do need to grab the ID of the last inserted row, i.e.
    #the row you just inserted into the database,
    #and assign it to the be the value of the @id attribute of the given instance.

    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    #(set class instance (aka last row) = student instance id attribute)
    #use a SQL query to grab the value of the ID column of the last inserted row,
    #and set that equal to the given song instance's id attribute
  end

  def self.create(name:, grade:)
      student = Student.new(name, grade)
      student.save
      student
  end

end

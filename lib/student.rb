  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
  # build an app for school to track their students
  # Each student instance will have two attributes: name and a grade (i.e. 9th, 10th, 11th, etc.)

class Student
  attr_accessor :name, :grade
  attr_reader :id

  # need:
  #     a class method on the Student class that creates the students table in the database
  #     a method that can drop that table
  #     a method #save, that can save the data concerning an individual student object to the database
  #     a method that both creates a new instance of the student class and then saves it to the database

  def initialize(name, grade, id=nil)
    @id = id
    @name = name
    @grade = grade
  end


  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      )
      SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE students"
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
    INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL
  DB[:conn].execute(sql, self.name, self.grade)
  @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(student_info)
    student = Student.new(student_info[:name], student_info[:grade])
    student.save
    student
  end
end

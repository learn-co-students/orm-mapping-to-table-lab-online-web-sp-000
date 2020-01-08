class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn] 
  
  attr_accessor :name, :grade
  attr_reader :id

  @@all

  def initialize (name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table 
    #a heredoc to set a variable, `sql`, equal to the necessary SQL statement
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
    sql = <<-SQL
      DROP TABLE students
    SQL

    DB[:conn].execute(sql)
  end
 
  def save
    #bound paremeters to pass the given student's name and grade into the SQL statement
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL
 
    DB[:conn].execute(sql, self.name, self.grade)
    
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    #grab the ID of the last inserted row, i.e. the row you just inserted into the database,
    # and assign it to the be the value of the @id attribute of the given instance
  end

  def self.create(name:, grade:)
    #This is a class method that uses keyword arguments. The keyword arguments are `name:` and `grade:`. 
    #Use the values of these keyword arguments to: 1) instantiate a new `Student` object with `Student.new(name, grade)` and
    # 2) save that new student object via `student.save`. The `#create` method should return the student object that it creates. 
    student = Student.new(name, grade)
    student.save
    student
  end

end

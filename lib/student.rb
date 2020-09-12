require 'pry'

class Student
  attr_accessor :name, :grade
  attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    #create the string statement
    #MUST BE <<-HI NOT <<- HI
    sql = <<-HI
      CREATE TABLE IF NOT EXISTS students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      )
    HI
    #execute:
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-HI
      DROP TABLE students
    HI
    #execute:
    DB[:conn].execute(sql)
  end

  def save #instance method
    #insert a row/song instance
    sql = <<-HI
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    HI
    #execute:
    DB[:conn].execute(sql, self.name, self.grade)
    #give the instance its id
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    #note: because you were told to make @id have a getter function only , no setter
    #that means u can't do things like song.id, self.id,, etc
    #u can still set it, but only inside the code so to speak, by referring it as @id 
    #WHEN YOU"RE DEFINING THE CODE
    #like in here
  end

  def self.create(hash) #class
    student = Student.new(hash[:name], hash[:grade])
    student.save
    student
  end 


end

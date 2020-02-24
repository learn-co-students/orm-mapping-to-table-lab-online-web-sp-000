class Student
  #  with DB[:conn] 
  attr_accessor :name, :grade
  attr_reader :id 
  
  def initialize(name, grade, id=nil)
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
    sql = <<-SQL 
    DROP TABLE students 
    SQL
    
    DB[:conn].execute(sql)
  end 
  
  def save 
    sql = <<-SQL
    INSERT INTO students (name, grade)
    VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
  end 
  
  def self.create(name, grade)
    new_student = Student.new(name, grade)
    new_student.save 
    new_student 
  end 
  
end

# #  def self.create(name, album)
#     song = Song.new(name, album)
#     song.save
#     song
#   end
# end

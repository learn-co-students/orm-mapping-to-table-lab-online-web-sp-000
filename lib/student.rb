class Student
  #  with DB[:conn] 
  attr_accessor :name, :grade
  attr_reader :id 
  
  def initialize(name, grade)
    @name = name 
    @grade = grade
    @id = nil 
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
    DROP TABLE IF EXISTS  students 
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
  
  def self.create(attr_hash)
    attr_hash.each {|key, value| self.send(("#{key}="), value)}
    new_student = Student.new(name, grade)
    new_student.save 
    new_student 
  end 
end

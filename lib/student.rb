require 'pry'

class Student

  attr_accessor :name, :grade 
  attr_reader :id
  
  def initialize(name, grade, id=nil)
    @name = name 
    @grade = grade 
    @id = id
  end 
  
  def self.create_table 
    sql = %{
      CREATE TABLE IF NOT EXISTS students ( 
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
      ) 
    } 
      
    DB[:conn].execute(sql)
  end 

  def self.drop_table
    DB[:conn].execute("DROP TABLE students")
  end 
  
  def save 
    sql = %{
      INSERT INTO students (name, grade)
      VALUES (?,?)
      }
    DB[:conn].execute(sql, @name, @grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end 
  
  def self.create(attri)
    noob = Student.new(attri[:name],attri[:grade])
    noob.save
    noob
  end 
  
  
  
end

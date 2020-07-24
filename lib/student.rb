class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
  attr_accessor :name, :grade
  attr_reader :id 
  
  
  def initialize (name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id 
  end 
  
  
  def self.create_table 
    quote = <<-q 
    CREATE TABLE IF NOT EXISTS students (
    id INTEGER PRIMARY KEY,
    name TEXT, 
    grade TEXT)
    q
    
    DB[:conn].execute(quote)
  end 
  
  def self.drop_table 
    DB[:conn].execute("DROP TABLE IF EXISTS students")
  end 
  
  def save
    quote = <<-q 
    INSERT INTO students (name, grade) VALUES (?,?) 
    q
    
    DB[:conn].execute(quote, self.name , self.grade)
    
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end 
  
  def self.create(name:, grade:)
    what = Student.new(name, grade)
    what.save 
    what 
  end 
  
end 
class Student
  attr_reader :id, :name, :grade  
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  def initialize(name, grade)
    @name = name 
    @grade = grade
  end
  
  def self.create_table
    sql = <<-SQL 
          CREATE TABLE IF NOT EXISTS students (
            id INTEGER PRIMARY KEY,
            name TEXT,
            album TEXT 
            )
        SQL
        DB[:conn].execute(sql)
  end 
  
  def self.drop_table 
    DROP TABLE students; 
  end 
  
  def save 
    # sql =<<-SQL
    #         INSERT INTO students(name,album)
    #         VALUES (?,?)
    #         SQL 
    #         DB[:conn].execute(sql,self.name,self.album)
  end 
end

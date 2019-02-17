class Student
        attr_accessor :name, :grade 
        attr_reader :id 
        
  
        
  def initialize(name, grade)
    
    @name = name
    @grade = grade
    @id = id 
    
    
  end 
  
  
        
  def self.create_table 
    sql = 
    "CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade INTEGER)"
   
    
    DB[:conn].execute(sql)
  end 
  
  def self.drop_table 
    sql = "DROP TABLE students"
    
    DB[:conn].execute(sql)
  end 
  
  def save 
   sql = "INSERT INTO students (name, grade) VALUES (?, ?)" 
   
   DB[:conn].execute(sql, self.name, self.grade)
   
   @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
   
  end 
  
  def self.create(hash) 
    
    @name = hash[:name]
    @grade = hash[:grade] 
    from_hash = self.new(@name, @grade) 
    from_hash.save 
    return from_hash
  end 
  
end
class Student
  attr_accessor :name, :grade
  attr_reader :id
    def initialize(name,grade, id = nil)
        @id = id
        @name = name
        @grade = grade

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
      @id =  DB[:conn].execute("SELECT id FROM students")[0][0]
   end

  def self.create(hash)
    name = []
    grade = []
    student = nil
     hash.each{|k,v| k == :name ? name << v :   grade << v }
     name.each_with_index{|name,index| student = Student.new(name,grade[index])
     student.save
   }
student
  end

end

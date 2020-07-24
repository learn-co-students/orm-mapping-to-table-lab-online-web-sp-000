class Student
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_reader :id, :name, :grade

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def save
    DB[:conn].execute("INSERT INTO students (name, grade)
                         VALUES ('#{name}', '#{grade}')")
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(hash)
    student = Student.new(hash[:name], hash[:grade])
    student.save
    student
  end

  def self.create_table
    DB[:conn].execute("CREATE TABLE students (
                         id INTEGER PRIMARY KEY,
                         name TEXT,
                         grade TEXT )")
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students")
  end
end

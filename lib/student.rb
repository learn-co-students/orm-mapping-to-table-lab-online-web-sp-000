class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id

  def initialize (name, grade, id=nil)
    @id = id
    @name = name
    @grade = grade
  end

  def self.create_table
    create_students = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      )
    SQL
    DB[:conn].execute(create_students)
  end

  def self.drop_table
    drop_students = <<-SQL
      DROP TABLE IF EXISTS students
    SQL
    DB[:conn].execute(drop_students)
  end

  def save
    student_inst = <<-SQL
      INSERT INTO students (name, grade) VALUES (?, ?)
    SQL
    DB[:conn].execute(student_inst, self.name, self.grade)
    @id = DB[:conn].execute('SELECT id FROM students ORDER BY id DESC LIMIT 1')[0][0]
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end



end

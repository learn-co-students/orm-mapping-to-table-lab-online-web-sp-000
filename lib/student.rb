class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade)
    self.name = name
    self.grade = grade
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?,?);
    SQL

    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute("SELECT id FROM students WHERE name = ?;", self.name)[0][0]
  end

  def self.create(hash)
    song = Student.new(hash[:name], hash[:grade])
    song.save
    song
  end

  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      );
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students;")
  end
end

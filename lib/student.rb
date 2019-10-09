require_relative "../config/environment.rb"

class Student

  attr_accessor :name, :grade
  attr_reader :id 
  
  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end
  
  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER)
        SQL
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    DB[:conn].execute("DROP TABLE students")
  end
  
  def save
      sql <<-SQL
        INSERT INTO students (name, grade)
        VALUES (?, ?)
        SQL
      DB[:conn].execute(sql,self.name, self.grade)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end
  
  def update
    sql = <<-SQL
      UPDATE students 
      SET name = ?, grade = ?
      WHERE id = ?
      SQL
    DB[:conn].execute(sql,self.name,self.grade,self.id)
  end
    
    
end

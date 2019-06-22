require 'pry'
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
            grade TEXT 
            )
        SQL
        DB[:conn].execute(sql)
  end 
  
  def self.drop_table
    sql = "DROP TABLE students"
          
    DB[:conn].execute(sql)
  end 
  
  def save 
    sql = "INSERT INTO students (name, grade) VALUES (?, ?)"
            DB[:conn].execute(sql,self.name,self.grade)
           @id = DB[:conn].execute("SElECT last_insert_rowid() FROM students")[0][0]
  end 
  
  def self.create(name:,grade:)
    student = Student.new(name, grade)
    student.save
    student
    #binding.pry 
    DB[:conn].execute(name: , grade:)
  end 
end

require_relative 'Department'
require_relative 'WorkWithDB'


class Department_list
  attr_accessor :department_list

  def initialize
    self.department_list = []
  end

  def add(department)
    self.department_list << department
  end

  def choose(numb)
    self.department_list[numb]
  end

  def read_db
    departments_names = DB_work.DB_connection.department_list_read_db
    departments_names.each do |department|
      new_dep = Department.new department
      new_dep.read_DB
      add(new_dep)
    end
  end

  def to_s
    str = ""
    self.department_list.each { |obj|  str += "#{obj.to_s}\n"}
    str
  end
end



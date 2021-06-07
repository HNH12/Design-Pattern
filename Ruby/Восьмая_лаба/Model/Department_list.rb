require_relative 'Department'
require_relative 'WorkWithDB'
require 'yaml'


class Department_list
  attr_accessor :department_list

  def initialize
    self.department_list = []
  end

  def add(department)
    department_list << department
  end

  def choose_instance(numb)
    self.department_list.each do |dep|
      if dep.department_id == numb
        return dep
      end
    end
    return 'Отдел с таким номером не существует'
  end

  def read_db
    departments_names = DB_work.DB_connection.department_list_read_db
    departments_names.each do |department|
      new_dep = Department.new department[0], department[1]
      new_dep.read_DB
      add(new_dep)
    end
  end

  def write_list_yaml
    File.open('Sources/dep_list.yaml', 'w:UTF-8') do |file|
      file.puts(@department_list.to_yaml)
    end
  end

  def to_s
    str = ""
    self.department_list.each { |obj|  str += "#{obj.to_s}\n"}
    str
  end

  def delete(department)
    department_list.delete_if { |x| x.department_id == department.department_id}
    DB_work.DB_connection.delete_department department
  end
end
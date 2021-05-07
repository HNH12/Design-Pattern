require_relative 'Department'


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
end
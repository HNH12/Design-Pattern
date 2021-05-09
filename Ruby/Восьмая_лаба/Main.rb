# require_relative 'Controller_department_list'
#
#
# class Main
#   def self.main
#     @@controller = Controller_department_list.new
#     @@controller.show_view
#   end
# end
#
# # if $0 == __FILE__
# #   Main.main
# # end
#

require_relative 'Terminal_view_employee_list'
require_relative 'Terminal_view_department_list'
require_relative 'Department_list'
require_relative 'ListEmployee'


class Controller_list
  def create_terminal
    raise ArgumentError
  end

  def create_list
    raise ArgumentError
  end

  def method_create
    list = create_list
    terminal = create_terminal

    terminal.show_view
  end
end


class Controller_department_list < Controller_list
  attr_accessor :dep

  def create_list
    self.dep = Department_list.new
    self.dep.read_db
    self.dep
  end

  def create_terminal
    Terminal_view_department_list.new dep
  end
end


# class Controller_employee_list < Controller_list
#   def create_terminal
#     super
#   end
#
#   def create_list
#     super
#   end
# end

test = Controller_department_list.new

test.create_list
test.create_terminal

test.method_create
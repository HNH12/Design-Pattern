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


# Зачем нужны эти проверки на объект (а именно terminal = create_terminal, так как суть фабрики меенять функционал
# в зависимости от переданного объекта), если есть self наследника.

# Суть фабрики в том, чтобы сделать создание только в фабричном методе, но тогда как можно пользоваться остальными методами?
# Если вынести в переменные класса, то они станут доступными в наследнике, и тогда смысл фабрики теряется.


class Controller_list
  private_class_method :new

  def create_terminal
    raise ArgumentError
  end

  def method_create
    @terminal, @list = create_terminal
  end

  def show_view
    @terminal.show_view
  end
end


class Controller_department_list < Controller_list
  public_class_method :new

  def create_terminal
    dep = Department_list.new
    dep.read_db
    return Terminal_view_department_list.new(dep), dep
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

test.create_terminal

test.method_create

test.show_view
puts test.instance_variable_get :@terminal
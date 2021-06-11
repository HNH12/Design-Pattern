require_relative 'View/Terminal_view_employee_list'
require_relative 'View/Terminal_view_department_list'
require_relative 'Model/Department_list'
require_relative 'Model/ListEmployee'
require_relative 'Control/Controller_department_list'
require_relative 'Control/Factory_controller_list/controller_department_list_factory'
require_relative 'Control/Factory_controller_list/controller_employee_list_factory'


class Main
  def self.main
    controller = Controller_department_list_factory.new
    controller = controller.create_controller_list
    controller.show_view
  end
end


if $0 == __FILE__
  Main.main
end
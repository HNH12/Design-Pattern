require_relative '../Controller_employee_list'

class Controller_employee_list_factory
  def create_controller_list
    Controller_employee_list.new
  end
end
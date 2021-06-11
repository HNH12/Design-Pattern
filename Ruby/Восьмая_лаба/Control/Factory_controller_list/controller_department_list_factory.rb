require_relative '../Controller_department_list'

class Controller_department_list_factory < Controller_list_factory


  def create_params
    c = Controller_department_list.new
    v = Terminal_view_department_list.new(c)
    list = Department_list.new
    return list, c, v
  end
end
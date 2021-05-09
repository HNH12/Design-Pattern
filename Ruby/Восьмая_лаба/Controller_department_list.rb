require_relative 'Controller_list'


class Controller_department_list < Controller_list
  def initialize
    @list = Department_list.new
    @list.read_db
    @view_list = Terminal_view_department_list.new @list
  end
end
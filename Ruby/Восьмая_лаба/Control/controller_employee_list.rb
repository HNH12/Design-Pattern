require_relative 'Controller_list'

class Controller_employee_list < Controller_list
  public_class_method :new

  def initialize
    @list = ListEmployee.new
    @list.read_list_DB
    @view_list = Terminal_view_employee_list.new @list
  end

  def show_list
    @list.to_s
  end

  def choose_instance(number)
    @view_list.choose_instance number
  end

  def add_instance(*args)
    @view_list.add_instance *args
  end

  def show_instance
    @view_list.show_instance
  end

  def show_view
    @view_list.show_view
  end

  def delete_instance
    @view_list.delete_instance
  end

  def close_view
    @view_list.close_view
  end
end
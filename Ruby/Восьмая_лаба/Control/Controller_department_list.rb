require_relative 'Controller_list'


class Controller_department_list < Controller_list
  public_class_method :new

  def initialize
    @list = Department_list.new
    @list.read_db
    @view_list = Terminal_view_department_list.new @list
  end

  def show_list
    @list.to_s
  end

  def delete(instance)
    @list.delete instance
  end

  def choose_instance(number)
    @list.choose_instance number
  end

  def add_instance(*args)
    @view_list.add_instance *args
  end

  def close_view
    @list.write_list_yaml
    exit 0
  end
end
require_relative 'Terminal_view_department_list'
require_relative 'Department_list'
require_relative 'Terminal_view_list'


class Controller_list
  def initialize
    @list = Department_list.new
    @list.read_db
    @view_list = Terminal_view_department_list.new @list
  end

  def show_list
    @view_list.show_list
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


test = Controller_list.new

test.show_list

test.choose_instance 0

test.show_instance
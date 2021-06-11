require_relative 'Controller_list'
require_relative 'Factory_controller_instance/controller_department_instance_factory'
require_relative '../View/Terminal_view_department_instance'

class Controller_department_list < Controller_list
  public_class_method :new

  def initialize

    #@view_list = Terminal_view_department_list.new self
  end

  def set_model model
    @list = model
  end

  def set_view view
    @view_list = view
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

  def add(dep_name)
    dep = Department.new dep_name, @list.return_increment
    @list.add dep
    DB_work.DB_connection.add_department dep
  end

  def close_view
    @list.write_list_yaml
    exit 0
  end

  def show_instance instance
    controller = Controller_department_instance_factory.new
    controller = controller.create_controller_instance instance
    view = Terminal_view_department_instance.new controller
    view.show
  end

  def show_view
    @view_list.show
  end
end
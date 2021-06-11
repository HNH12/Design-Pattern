require_relative 'Controller_instance'
require_relative '../View/Terminal_view_department_instance'
require_relative '../View/Terminal_view_employee_list'
require_relative '../Control/Factory_controller_list/controller_employee_list_factory'


class Controller_department_instance < Controller_instance
  attr_accessor :instance, :view

  def initialize(instance)
    self.instance = instance
    self.view = Terminal_view_department_instance.new self
  end

  def show_list
    instance.post_list.to_s
  end

  def add_post(post_name, fixed_salary, premium_salary, quarterly_award, possible_bonus_percent)
    post = Post.new(@instance.post_list.return_increment, post_name, fixed_salary,
                                                         premium_salary, quarterly_award, possible_bonus_percent,
                                                         @instance)

    @instance.add post
    DB_work.DB_connection.add_post post
  end

  def delete_post post_num
    @instance.delete_post post_num
  end

  def show_employee_list
    controller = Controller_employee_list_factory.new
    controller = controller.create_controller_list
    view = Terminal_view_employee_list.new controller
    view.show
  end
end
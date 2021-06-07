require_relative 'Terminal_view_list'
require_relative 'ListEmployee'


class Terminal_view_employee_list < Terminal_view_list
  attr_accessor :choose_instance_obj

  def initialize(list)
    super list
  end

  def choose_instance(number)
    self.choose_instance_obj = @list.choose number
  end

  def show_instance
    puts self.choose_instance_obj
  end
end


# test_list = ListEmployee.new
# test_list.read_list_DB
#
# test = Terminal_view_employee_list.new test_list
# test.choose_instance 0
# test.show_instance
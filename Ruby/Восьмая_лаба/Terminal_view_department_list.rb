require_relative 'Department_list'

class Terminal_view_department_list
  attr_accessor :department_list, :choose_instance_obj

  def initialize(department_list)
    self.department_list = department_list
  end

  def show_list
    puts self.department_list
  end

  def show_view
    puts 'Вы тут'
  end

  def add_instance(*args)

  end

  def choose_instance(number)
    self.choose_instance_obj = self.department_list.choose(number)
  end

  def show_instance
    puts self.choose_instance_obj
  end

  def delete_instance

  end

  def close_view
    exit 0
  end
end


# test_dep = Department.new 'Отдел кадров'
#
# test_post_list = Post_list.new test_dep
# test_post = Post.new('Программист', 40000, 10000, 3000, 50)
#
# test_post_list.add test_post
#
# test_dep.post_list =test_post_list
#
# test = Terminal_view_department_list.new test_dep
#
# # test.show_list
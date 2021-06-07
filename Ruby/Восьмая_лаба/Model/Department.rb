require_relative 'Post_list'


class Department
  attr_accessor :department_name, :department_id

  def initialize(department_name, department_id)
    self.department_id = department_id
    self.department_name = department_name
  end

  def post_list=(post_list)
    @post_list = post_list
  end

  def post_list
    @post_list
  end

  def read_DB
    @post_list = Post_list.new self
    @post_list.read_DB
  end

  def to_s
    "#{self.department_id} #{self.department_name}"
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
# puts test_dep.post_list.choose(0).get_full_info

# test_dep = Department.new 'Отдел кадров'
# test_dep.post_list = Post_list.new test_dep
#
# test_dep.read_DB
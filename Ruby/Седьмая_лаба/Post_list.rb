require_relative 'Post'
require_relative 'WorkWithDB'
require 'mysql2'


class Post_list
  attr_accessor :department, :post_list

  def initialize(department=nil)
    self.department = department
    self.post_list = []
  end

  def add(post)
    self.post_list << post
  end

  def choose(numb)
    self.post_list[numb]
  end

  def read_DB
    self.post_list = DB_work.DB_connection.post_list_read_db department.department_name
  end
end


# department = Department.new
#
# test_post_list = Post_list.new department
# test_post = Post.new('Программист', 40000, 10000, 3000, 50)
#
# test_post_list.add test_post
#
# puts test_post_list.choose(0).get_full_info

# test_list = Post_list.new
#
# test_list.read_DB
#
# puts test_list.choose(0).get_full_info
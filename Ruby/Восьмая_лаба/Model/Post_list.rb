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
    self.post_list = DB_work.DB_connection.post_list_read_db department
  end

  def to_s
    str = ""
    self.post_list.each { |obj| str += "#{obj}\n"}
    str
  end

  def return_increment
    if post_list.size == 0
      return 1
    end
      return post_list[post_list.size-1].id + 1
  end

  def delete post
    post_list.delete_if { |x| x.id == post.id}
    DB_work.DB_connection.delete_post post
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
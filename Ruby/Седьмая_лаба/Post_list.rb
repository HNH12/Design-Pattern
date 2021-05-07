require_relative 'Post'


class Post_list
  attr_accessor :department, :post_list

  def initialize(department)
    self.department = department
    self.post_list = []
  end

  def add(post)
    self.post_list << post
  end

  def choose(numb)
    self.post_list[numb]
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